//
//  DisplayDataRouter.swift
//  Mazaady
//
//  Created by Hamada Ragab on 15/01/2024.
//

import Foundation
import UIKit
protocol DisplayDataRouterProtocol {
    func dismiss()
}
class DisplayDataRouter {
    var viewController: DisplayDataViewController?
    init(viewController: DisplayDataViewController) {
        self.viewController = viewController
    }
    func start(displayedData:[DisplayedData]) {
        viewController?.router = self
        viewController?.viewModel = DisplayDataViewModel(displayedData: displayedData)
    }
}
extension DisplayDataRouter: DisplayDataRouterProtocol{
    
    func dismiss() {
        self.viewController?.dismiss(animated: true)
    }
}
