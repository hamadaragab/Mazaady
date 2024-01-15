//
//  String.swift
//  Mazaady
//
//  Created by Hamada Ragab on 14/01/2024.
//

import Foundation
import UIKit
extension String {
    var width: CGFloat {
        let font = UIFont.systemFont(ofSize: 16.0, weight: .medium)
        let attributes = [NSAttributedString.Key.font: font]
        let size = (self as NSString).size(withAttributes: attributes)
        return size.width + 20
    }
}
