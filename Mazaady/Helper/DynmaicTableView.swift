//
//  DynmaicTableView.swift
//  Mazaady
//
//  Created by Hamada Ragab on 15/01/2024.
//

import Foundation
import UIKit
class DynmaicTableView: UITableView {
   override var intrinsicContentSize: CGSize {
       self.layoutIfNeeded()
       return self.contentSize
   }

   override var contentSize: CGSize {
       didSet{
           self.invalidateIntrinsicContentSize()
       }
   }

   override func reloadData() {
       super.reloadData()
       self.invalidateIntrinsicContentSize()
   }
}
