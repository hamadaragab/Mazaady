//
//  DiscoverRouter.swift
//  Mazaady
//
//  Created by Hamada Ragab on 13/01/2024.
//

import Foundation
import UIKit
protocol DiscoverRouterProtocol {
    func dismiss()
}
class DiscoverRouter {
    var viewController: DiscoverViewController?
    init(viewController: DiscoverViewController) {
        self.viewController = viewController
    }
    func start() {
        viewController?.router = self
        viewController?.viewModel = DiscoverViewModel()
    }
}
extension DiscoverRouter: DiscoverRouterProtocol{
    
    func dismiss() {
        self.viewController?.dismiss(animated: true)
    }
}
