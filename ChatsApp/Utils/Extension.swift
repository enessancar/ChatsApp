//
//  Extension.swift
//  ChatsApp
//
//  Created by Enes Sancar on 11.01.2023.
//

import UIKit
import JGProgressHUD

extension UIViewController {
    func configureGradientLayer() {
        lazy var gradient: CAGradientLayer = {
            let gradient = CAGradientLayer()
            gradient.type = .axial
            gradient.colors = [
                UIColor.systemBlue.cgColor,
                UIColor.systemPink.cgColor,
            ]
            gradient.locations = [0,1]
            return gradient
        }()
        gradient.frame = view.bounds
        view.layer.addSublayer(gradient)
    }

    func showProgressHud(showProgress: Bool) {
        let progressHud = JGProgressHUD(style: .dark)
        progressHud.textLabel.text = "Please wait"
        if showProgress {
            progressHud.show(in: view)
        }
        progressHud.dismiss(afterDelay: 3)
        progressHud.dismiss(animated: true)
    }
    
    func add(_ child: UIViewController) {
        addChild(child)
        self.view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    func remove() {
        willMove(toParent: self)
        self.view.removeFromSuperview()
        removeFromParent()
    }
}

