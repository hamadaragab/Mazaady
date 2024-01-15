//
//  ProfileViewModel.swift
//  Mazaady
//
//  Created by Hamada Ragab on 13/01/2024.
//

import Foundation
import RxCocoa
import RxSwift
protocol ProfileViewModelProtocol: AnyObject {
    var input: ProfileViewModel.Input {get}
    var output: ProfileViewModel.Output {get}
    func viewDidLoad()
}
class ProfileViewModel:ProfileViewModelProtocol {
    var input: Input = .init()
    var output: Output = .init()
    private let disposeBag = DisposeBag()
    func viewDidLoad(){
        
    }
}

extension ProfileViewModel: BaseViewModel {
    struct Input {
    }
    class Output {
    }
    
}
