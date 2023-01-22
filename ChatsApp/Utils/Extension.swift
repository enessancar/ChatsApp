//
//  Extension.swift
//  ChatsApp
//
//  Created by Enes Sancar on 11.01.2023.
//

import UIKit

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
}
