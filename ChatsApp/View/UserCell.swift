//
//  UserCell.swift
//  ChatsApp
//
//  Created by Enes Sancar on 28.01.2023.
//

import UIKit

class UserCell: UITableViewCell {
    
    //MARK: - Properties
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .gray
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.text = "Title"
        return label
    }()
    
    private let subTitleLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .lightGray
        label.text = "Subtitle"
        return label
    }()
    
    private var stackView = UIStackView()
    
    //MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
        setup()
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
}

//MARK: - Helpers
extension UserCell {
    
    private func setup() {
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.layer.cornerRadius = 55 / 2
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView = UIStackView(arrangedSubviews: [titleLabel, subTitleLabel])
        stackView.axis = .vertical        
    }
    
    private func layout() {
        addSubview(profileImageView)
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            profileImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            profileImageView.heightAnchor.constraint(equalToConstant: 55),
            profileImageView.widthAnchor.constraint(equalToConstant: 55),
            profileImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            
            stackView.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
}
