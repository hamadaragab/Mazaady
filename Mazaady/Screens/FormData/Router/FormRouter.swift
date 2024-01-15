//
//  FormRouter.swift
//  Mazaady
//
//  Created by Hamada Ragab on 13/01/2024.
//

import Foundation
import UIKit
protocol FormRouterProtocol {
    func dismiss()
    func goToDisplayData(displayedData:[DisplayedData])
}
class FormRouter {
    var viewController: FormViewController?
    init(viewController: FormViewController) {
        self.viewController = viewController
    }
    func start() {
        viewController?.router = self
        let repository = FormRepository()
        viewController?.viewModel = FormViewModel(repository: repository)
    }
}
extension FormRouter: FormRouterProtocol{
    func goToDisplayData(displayedData:[DisplayedData]) {
        let displayDataView = DisplayDataViewController()
        DisplayDataRouter(viewController: displayDataView).start(displayedData: displayedData)
        displayDataView.modalPresentationStyle = .fullScreen
        self.viewController?.present(displayDataView, animated: true)
    }
    func dismiss() {
        self.viewController?.dismiss(animated: true)
    }
    
}
