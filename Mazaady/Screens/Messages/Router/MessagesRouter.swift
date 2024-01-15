//
//  MessagesRouter.swift
//  Mazaady
//
//  Created by Hamada Ragab on 13/01/2024.
//

import Foundation
import UIKit
protocol MessagesRouterProtocol {
    func dismiss()
}
class MessagesRouter {
    var viewController: MessagesViewController?
    init(viewController: MessagesViewController) {
        self.viewController = viewController
    }
    func start() {
        viewController?.router = self
        viewController?.viewModel = MessagesViewModel()
    }
}
extension MessagesRouter: MessagesRouterProtocol{
    
    func dismiss() {
        self.viewController?.dismiss(animated: true)
    }
}
