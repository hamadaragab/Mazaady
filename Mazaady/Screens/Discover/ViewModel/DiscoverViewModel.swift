//
//  DiscoverViewModel.swift
//  Mazaady
//
//  Created by Hamada Ragab on 13/01/2024.
//

import Foundation
import RxCocoa
import RxSwift
protocol DiscoverViewModelProtocol: AnyObject {
    var input: DiscoverViewModel.Input {get}
    var output: DiscoverViewModel.Output {get}
    func viewDidLoad()
}
class DiscoverViewModel:DiscoverViewModelProtocol {
    var input: Input = .init()
    var output: Output = .init()
    private let disposeBag = DisposeBag()
    func viewDidLoad(){
        
    }
}

extension DiscoverViewModel: BaseViewModel {
    struct Input {
    }
    class Output {
      
    }
    
}
