//
//  MessageCell.swift
//  ChatsApp
//
//  Created by Enes Sancar on 30.01.2023.
//

import UIKit

class MessageCell: UICollectionViewCell {
    
    //MARK: - Properties
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let messsageContainerView: UIView = {
        let containerView = UIView()
        return containerView
    }()
    
    private let messageTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .clear
        textView.isScrollEnabled = false
        textView.isEditable = false
        textView.font = .preferredFont(forTextStyle: .title3)
        textView.text = "Message"
        textView.textColor = .white
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
extension MessageCell {
    func style() {
        backgroundColor = .systemBackground
        
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.layer.cornerRadius = 34 / 2
        
        messsageContainerView.translatesAutoresizingMaskIntoConstraints = false
        messsageContainerView.layer.cornerRadius = 10
        messsageContainerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        
        messageTextView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func layout() {
        addSubview(profileImageView)
        addSubview(messsageContainerView)
        addSubview(messageTextView)
        
        NSLayoutConstraint.activate([
            profileImageView.widthAnchor.constraint(equalToConstant: 34),
            profileImageView.heightAnchor.constraint(equalToConstant: 34),
            profileImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            profileImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            
            messsageContainerView.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            messsageContainerView.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 8),
            messsageContainerView.widthAnchor.constraint(lessThanOrEqualToConstant: 300),
            
            messageTextView.topAnchor.constraint(equalTo: messsageContainerView.topAnchor),
            messageTextView.leadingAnchor.constraint(equalTo: messsageContainerView.leadingAnchor),
            messageTextView.trailingAnchor.constraint(equalTo: messsageContainerView.trailingAnchor),
            messageTextView.bottomAnchor.constraint(equalTo: messsageContainerView.bottomAnchor)
        ])
    }
}
