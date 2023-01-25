//
//  AuthenticationInputView.swift
//  ChatsApp
//
//  Created by Enes Sancar on 21.01.2023.
//

import UIKit

class AuthenticationInputView: UIView {
    
    init(image: UIImage, textField: UITextField) {
        super.init(frame: .zero)
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = image
        imageView.tintColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        addSubview(textField)
        
        let dividerView = UIView()
        dividerView.backgroundColor = .white
        dividerView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(dividerView)
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 24),
            imageView.heightAnchor.constraint(equalToConstant: 24),
            
            textField.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            textField.leadingAnchor.constraint(equalTo: imageView.trailingAnchor,constant: 8),
            textField .trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            
            dividerView.heightAnchor.constraint(equalToConstant: 0.7),
            dividerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            dividerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            dividerView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
}
