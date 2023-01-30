//
//  ChatInputView.swift
//  ChatsApp
//
//  Created by Enes Sancar on 29.01.2023.
//

import UIKit

class ChatInputView: UIView {
    
    //MARK: - Properties
    private let textInputView: UITextView = {
        let textView = UITextView()
        return textView
    }()
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
}

//MARK: - Helpers
extension  ChatInputView {
    
    private func style() {
        backgroundColor = .systemBackground
        textInputView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func layout() {
        addSubview(textInputView)
        
        NSLayoutConstraint.activate([
            textInputView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            textInputView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8)
        ])
    }
}
