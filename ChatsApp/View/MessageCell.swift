//
//  MessageCell.swift
//  ChatsApp
//
//  Created by Enes Sancar on 9.02.2023.
//

import UIKit
import SDWebImage

class MessageCell: UITableViewCell {
    
    //MARK: - Properties
    var lastUser: LastUser? {
        didSet {
            configureMessageCell()
        }
    }
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    private let lastMessageLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
    
    private var stackView = UIStackView()
    
    private let timesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .black
        label.text = "5:5"
        return label
    }()
    
    //MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
}

//MARK: - Helpers
extension MessageCell {
    private func setup() {
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.layer.cornerRadius = 55 / 2
        
        stackView = UIStackView(arrangedSubviews: [usernameLabel, lastMessageLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        
        timesLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func layout() {
        addSubview(profileImageView)
        addSubview(stackView)
        addSubview(timesLabel)
        
        NSLayoutConstraint.activate([
            profileImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            profileImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            profileImageView.heightAnchor.constraint(equalToConstant: 55),
            profileImageView.widthAnchor.constraint(equalToConstant: 55),
            
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            
            timesLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            timesLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
    }
    
    private func configureMessageCell() {
        guard let lastUser = self.lastUser else { return }
        let viewModel = MessageViewModel(lastUser: lastUser)
        self.usernameLabel.text = lastUser.user.name
        self.lastMessageLabel.text = lastUser.message.text
        self.profileImageView.sd_setImage(with: viewModel.profileImage)
        self.timesLabel.text = viewModel.timestampString
    }
}
