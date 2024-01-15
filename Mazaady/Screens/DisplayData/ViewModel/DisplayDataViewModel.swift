//
//  DisplayDataViewModel.swift
//  Mazaady
//
//  Created by Hamada Ragab on 15/01/2024.
//

import Foundation
import RxCocoa
import RxSwift
protocol DisplayDataViewModelProtocol: AnyObject {
    var input: DisplayDataViewModel.Input {get}
    var output: DisplayDataViewModel.Output {get}
    func viewDidLoad()
}
class DisplayDataViewModel:DisplayDataViewModelProtocol {
    var input: Input = .init()
    var output: Output = .init()
    private let disposeBag = DisposeBag()
    private var displayedData: [DisplayedData] = []
    init(displayedData:[DisplayedData]) {
        self.displayedData = displayedData
    }
    func viewDidLoad(){
        output.displayedData.onNext(displayedData)
    }
}

extension DisplayDataViewModel: BaseViewModel {
    struct Input {
    }
    class Output {
        let displayedData = PublishSubject<[DisplayedData]>()
    }
    
}
