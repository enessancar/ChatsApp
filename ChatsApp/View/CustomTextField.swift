//
//  CustomTextField.swift
//  ChatsApp
//
//  Created by Enes Sancar on 21.01.2023.
//

import UIKit

class CustomTextField: UITextField {
    
    init(placeHolder: String) {
        super.init(frame: .zero)
        attributedPlaceholder = NSAttributedString(string: placeHolder, attributes: [.foregroundColor: UIColor.white])
        borderStyle = .none
        textColor = .white
    }
    
    required init(coder: NSCoder) {
        fatalError("Unsupported")
    }
}
