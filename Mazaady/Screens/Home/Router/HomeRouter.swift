//
//  HomeRouter.swift
//  Mazaady
//
//  Created by Hamada Ragab on 13/01/2024.
//

import Foundation
import UIKit
protocol HomeRouterProtocol {
    func dismiss()
}
class HomeRouter {
    var viewController: HomeViewController?
    init(viewController: HomeViewController) {
        self.viewController = viewController
    }
    func start() {
        viewController?.router = self
        viewController?.viewModel = HomeViewModel()
    }
}
extension HomeRouter: HomeRouterProtocol{
    
    func dismiss() {
        self.viewController?.dismiss(animated: true)
    }
}
