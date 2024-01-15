//
//  MessagesViewModel.swift
//  Mazaady
//
//  Created by Hamada Ragab on 13/01/2024.
//

import Foundation
import RxCocoa
import RxSwift
protocol MessagesViewModelProtocol: AnyObject {
    var input: MessagesViewModel.Input {get}
    var output: MessagesViewModel.Output {get}
    func viewDidLoad()
}
class MessagesViewModel:MessagesViewModelProtocol {
    var input: Input = .init()
    var output: Output = .init()
    private let disposeBag = DisposeBag()
    func viewDidLoad(){
        
    }
}

extension MessagesViewModel: BaseViewModel {
    struct Input {
    }
    class Output {
        let progress = PublishSubject<Float>()
        let goToHome = PublishSubject<()>()
        let message = PublishSubject<String>()
    }
    
}
