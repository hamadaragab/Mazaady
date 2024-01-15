//
//  Spinner.swift
//  Mazaady
//
//  Created by Hamada Ragab on 15/01/2024.
//

import Foundation
import RPCircularProgress

class Spinner {
    
    lazy fileprivate var spinnerView: RPCircularProgress = {
        let progress = RPCircularProgress()
        progress.tag = 1010
        progress.progressTintColor = UIColor.mainColor
        progress.trackTintColor = UIColor.systemGray6
        progress.indeterminateDuration = 0.6
        progress.thicknessRatio = 0.2
        return progress
    }()
    
    func showAddedto(_ view:UIView) {
        if let _ = view.viewWithTag(1010) {
            
        }else {
            spinnerView.enableIndeterminate()
            view.addSubview(spinnerView)
            spinnerView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                spinnerView.centerXAnchor.constraint(equalTo:view.centerXAnchor),
                spinnerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                spinnerView.heightAnchor.constraint(equalToConstant: 40),
                spinnerView.widthAnchor.constraint(equalToConstant: 40)
                
            ])
        }
    }
    func hideFrom(_ view:UIView){
        let spinner = view.viewWithTag(1010)
        spinner?.removeFromSuperview()
    }
}
