//
//  ProfileRouter.swift
//  Mazaady
//
//  Created by Hamada Ragab on 13/01/2024.
//

import Foundation
import UIKit
protocol ProfileRouterProtocol {
    func dismiss()
}
class ProfileRouter {
    var viewController: ProfileViewController?
    init(viewController: ProfileViewController) {
        self.viewController = viewController
    }
    func start() {
        viewController?.router = self
        viewController?.viewModel = ProfileViewModel()
    }
}
extension ProfileRouter: ProfileRouterProtocol{
    
    func dismiss() {
        self.viewController?.dismiss(animated: true)
    }
}
