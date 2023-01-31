//
//  ChatInputView.swift
//  ChatsApp
//
//  Created by Enes Sancar on 29.01.2023.
//

import UIKit

protocol ChatInputViewProtocol: AnyObject {
    func sendMessage(_ chatInputView: ChatInputView, message: String)
}

class ChatInputView: UIView {
    
    //MARK: - Properties
    weak var delegate: ChatInputViewProtocol?
    
    private let textInputView: UITextView = {
        let textView = UITextView()
        textView.font = .preferredFont(forTextStyle: .title3)
        return textView
    }()
    
    private lazy var sendButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Send", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = .preferredFont(forTextStyle: .title3)
        button.addTarget(self, action: #selector(handleSendButton), for: .touchUpInside)
        return button
    }()
    
    private let placeHolderLabel: UILabel = {
        let label = UILabel()
        label.text = "Message"
        label.font = .preferredFont(forTextStyle: .title2)
        return label
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
        autoresizingMask = .flexibleHeight
        configureGradientLayer()
        clipsToBounds = true
        layer.cornerRadius = 15
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        textInputView.translatesAutoresizingMaskIntoConstraints = false
        textInputView.layer.cornerRadius = 10
        NotificationCenter.default.addObserver(self, selector: #selector(handleTextInputView), name: UITextView.textDidChangeNotification, object: nil)
        
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        placeHolderLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func layout() {
        addSubview(textInputView)
        addSubview(sendButton)
        addSubview(placeHolderLabel)
        
        NSLayoutConstraint.activate([
            textInputView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            textInputView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            textInputView.trailingAnchor.constraint(equalTo: sendButton.leadingAnchor, constant: -4),
            textInputView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            
            sendButton.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            sendButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            sendButton.heightAnchor.constraint(equalToConstant: 55),
            sendButton.widthAnchor.constraint(equalToConstant: 55),
            
            placeHolderLabel.topAnchor.constraint(equalTo: textInputView.topAnchor),
            placeHolderLabel.leadingAnchor.constraint(equalTo: textInputView.leadingAnchor,constant: 8),
            placeHolderLabel.bottomAnchor.constraint(equalTo: textInputView.bottomAnchor, constant: -8),
            placeHolderLabel.trailingAnchor.constraint(equalTo: textInputView.trailingAnchor)
        ])
    }
    func clear() {
        textInputView.text = nil
        placeHolderLabel.isHidden = false
    }
}

//MARK: - Selector
extension ChatInputView {
    @objc private func handleTextInputView() {
        placeHolderLabel.isHidden = !textInputView.text.isEmpty
    }
    
    @objc private func handleSendButton(_ sender: UIButton) {
        guard let message = textInputView.text else { return }
        self.delegate?.sendMessage(self, message: message)
    }
}
