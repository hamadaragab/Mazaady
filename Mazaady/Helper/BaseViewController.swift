//
//  BaseViewController.swift
//  Mazaady
//
//  Created by Hamada Ragab on 15/01/2024.
//

import Foundation
import UIKit
class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    func showHud(showLoding: Bool){
        if showLoding {
            self.view.isUserInteractionEnabled = false
            Spinner().showAddedto(self.view)
        }else {
            self.view.isUserInteractionEnabled = true
            Spinner().hideFrom(self.view)
        }
    }
}
