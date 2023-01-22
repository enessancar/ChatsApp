//
//  ViewController.swift
//  ChatsApp
//
//  Created by Enes Sancar on 11.01.2023.
//

import UIKit

class LoginViewController: UIViewController {
    
    //MARK: - Properties
    private let logoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .white
        imageView.image = UIImage(systemName: "ellipsis.message")
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var emailContainerView: AuthenticationInputView = {
        let containerView = AuthenticationInputView(image: UIImage(systemName: "envelope")!, textField: emailTextField)
        return containerView
    }()
    
    private let emailTextField = CustomTextField(placeHolder: "Email")
    
    private lazy var passwordContainerView: AuthenticationInputView = {
        let containerView = AuthenticationInputView(image: UIImage(systemName: "lock")!, textField: passwordTextField)
        return containerView
    }()
    private let passwordTextField: CustomTextField = {
        let textField = CustomTextField(placeHolder: "Password")
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private var stackView =  UIStackView()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.isEnabled = false
        return button
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureGradientLayer()
        style()
        layout()
    }
}

//MARK: - Helpers

extension LoginViewController {
    
    private func style() {
        self.navigationController?.navigationBar.isHidden = true
        
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        emailContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView, loginButton])
        stackView.axis = .vertical
        stackView.spacing = 14
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    private func layout() {
        
        view.addSubview(logoImage)
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            logoImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            logoImage.heightAnchor.constraint(equalToConstant: 150),
            logoImage.widthAnchor.constraint(equalToConstant: 150),
            logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            stackView.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 32),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            emailContainerView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
