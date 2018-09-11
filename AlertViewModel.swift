//
//  AlertViewModel.swift
//  CustomAlertView
//
//  Created by Shantaram Kokate on 9/11/18.
//  Copyright © 2018 Shantaram Kokate. All rights reserved.


import Foundation
import UIKit
protocol AlertViewModel {
    func show(animated:Bool)
    func dismiss(animated:Bool)
    var backgroundView:UIView {get set}
    var containerView:UIView {get set}
}
extension AlertViewModel where Self: UIView {
    func show(animated:Bool){
        self.backgroundView.alpha = 0
        if var topController = UIApplication.shared.delegate?.window??.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            topController.view.addSubview(self)
        }
        if animated {
            self.containerView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            UIView.animate(withDuration: 0.11, animations: {
                self.backgroundView.alpha = 1.0
                self.containerView.transform = .identity
            }) { (completion) in
                self.backgroundView.alpha = 1.0
            }
        }
    }
    func dismiss(animated: Bool) {
        if animated {
            self.backgroundView.alpha = 1.0
            self.containerView.transform = .identity
            UIView.animate(withDuration: 0.11, animations: {
                self.backgroundView.alpha = 0.0
                self.containerView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            }) { (completion) in
                self.backgroundView.alpha = 0.0
                self.removeFromSuperview()
            }
        } else {
            self.backgroundView.alpha = 0.0
            self.removeFromSuperview()
        }
        
    }
}
