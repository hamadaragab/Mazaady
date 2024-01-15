//
//  TabBarRouter.swift
//  Mazaady
//
//  Created by Hamada Ragab on 13/01/2024.
//

import Foundation
import UIKit
protocol TabBarRouterProtocol {
    func dismiss()
}
class TabBarRouter {
    var viewController: TabBarViewController?
    init(viewController: TabBarViewController) {
        self.viewController = viewController
    }
    func start() {
        viewController?.router = self
        viewController?.viewModel = TabBarViewModel()
    }
}
extension TabBarRouter: TabBarRouterProtocol{
    
    func dismiss() {
        self.viewController?.dismiss(animated: true)
    }
}
