//
//  MessageCell.swift
//  ChatsApp
//
//  Created by Enes Sancar on 30.01.2023.
//

import UIKit
import SDWebImage
import SnapKit

class NewMessageCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    // kullanıcının ve bizim attığımız mesajlar farklı taraflarda gözükmesi için
    var messageContainerViewLeft: NSLayoutConstraint!
    var messageContainerViewRight: NSLayoutConstraint!
    
    var message: Message?{
        didSet {
            configure()
        }
    }
    
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
extension NewMessageCell {
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
        
        messageTextView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalTo(messsageContainerView)
        }
        
        NSLayoutConstraint.activate([
            profileImageView.widthAnchor.constraint(equalToConstant: 34),
            profileImageView.heightAnchor.constraint(equalToConstant: 34),
            profileImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            profileImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            
            messsageContainerView.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            messsageContainerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            messsageContainerView.widthAnchor.constraint(lessThanOrEqualToConstant: 300),
        ])
        
        self.messageContainerViewLeft = messsageContainerView.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 8)
        self.messageContainerViewLeft.isActive = false
        
        self.messageContainerViewRight = messsageContainerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        self.messageContainerViewRight.isActive = false
    }
    private func configure() {
        guard let message = self.message else { return }
        let viewModel = NewMessageViewModel(message: message)
        messageTextView.text = message.text
        messsageContainerView.backgroundColor = viewModel.messageBackgroundColor
        
        messageContainerViewRight.isActive = viewModel.currentUserActive
        messageContainerViewLeft.isActive = !viewModel.currentUserActive
        profileImageView.isHidden = viewModel.currentUserActive // bensem profile image gözükmesin
        profileImageView.sd_setImage(with: viewModel.profileImageView)
        
        if viewModel.currentUserActive {
            messsageContainerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner]
        } else {
            messsageContainerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        }
    }
}
