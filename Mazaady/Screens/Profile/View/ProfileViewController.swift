//
//  ProfileViewController.swift
//  Mazaady
//
//  Created by Hamada Ragab on 13/01/2024.
//

import UIKit
import RxSwift
import RxCocoa
class ProfileViewController: UIViewController {
    private let disposeBag = DisposeBag()
    var viewModel: ProfileViewModelProtocol?
     var router: ProfileRouterProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
