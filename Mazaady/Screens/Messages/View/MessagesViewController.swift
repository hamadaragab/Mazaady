//
//  MessagesViewController.swift
//  Mazaady
//
//  Created by Hamada Ragab on 13/01/2024.
//

import UIKit
import RxSwift
import RxCocoa
class MessagesViewController: UIViewController {
    private let disposeBag = DisposeBag()
    var viewModel: MessagesViewModelProtocol?
     var router: MessagesRouterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
