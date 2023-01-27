//
//  ViewController.swift
//  ChatsApp
//
//  Created by Enes Sancar on 11.01.2023.
//

import UIKit
import JGProgressHUD

class LoginViewController: UIViewController {
    
    private var viewModel = LoginViewModel()
    
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
    
    private lazy var passwordContainerView: AuthenticationInputView = {
        let containerView = AuthenticationInputView(image: UIImage(systemName: "lock")!, textField: passwordTextField)
        return containerView
    }()
    
    private let emailTextField = CustomTextField(placeHolder: "Email")
    private let passwordTextField: CustomTextField = {
        let textField = CustomTextField(placeHolder: "Password")
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private var stackView =  UIStackView()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.isEnabled = false
        button.addTarget(self, action: #selector(handleLoginButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var switchToRegistrationPage: UIButton = {
        let button = UIButton(type: .system)
        let attirubedTitle = NSMutableAttributedString(string: "Click to become a member", attributes: [.foregroundColor: UIColor.white, .font: UIFont.boldSystemFont(ofSize: 14)])
        button.setAttributedTitle(attirubedTitle, for: .normal)
        button.addTarget(self, action: #selector(handleGoToRegisterView), for: .touchUpInside)
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

//MARK: - Selector
extension LoginViewController {
    
    @objc private func handleLoginButton(_ sender: UIButton) {
        guard let emailText = emailTextField.text, let passwordText = passwordTextField.text else { return }
        showProgressHud(showProgress: true)
        AuthenticationService.login(withEmail: emailText, withPassword: passwordText) { result, error in
            if error != nil {
                self.makeAlert(title: "ERROR", message: "Login operation failed")
                self.showProgressHud(showProgress: false) // gerek kalmadı başarısız giremeyecek
                return
            }
            self.showProgressHud(showProgress: false)
            self.dismiss(animated: true)
        }
    }
    
    @objc private func handleTextFieldChange(_ sender: UITextField) {
        if sender == emailTextField {
            viewModel.emailTextField = sender.text
        } else {
            viewModel.passwordTextField = sender.text
        }
        loginButtonStatus()
    }
    
    @objc private func handleGoToRegisterView(_ sender: UIButton) {
        let controller = RegisterViewController()
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

//MARK: - Helpers

extension LoginViewController {
    
    private func loginButtonStatus() {
        if viewModel.status {
            loginButton.isEnabled = true
            loginButton.backgroundColor = .systemBlue
        } else {
            loginButton.isEnabled = false
            loginButton.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        }
    }
    
    private func style() {
        self.navigationController?.navigationBar.isHidden = true
        
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        emailContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView, loginButton])
        stackView.axis = .vertical
        stackView.spacing = 14
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        emailTextField.addTarget(self, action: #selector(handleTextFieldChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(handleTextFieldChange), for: .editingChanged)
        
        switchToRegistrationPage.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    private func layout() {
        
        view.addSubview(logoImage)
        view.addSubview(stackView)
        view.addSubview(switchToRegistrationPage)
        
        NSLayoutConstraint.activate([
            logoImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            logoImage.heightAnchor.constraint(equalToConstant: 150),
            logoImage.widthAnchor.constraint(equalToConstant: 150),
            logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            stackView.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 32),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            emailContainerView.heightAnchor.constraint(equalToConstant: 50),
            
            switchToRegistrationPage.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            switchToRegistrationPage.bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 40)
        ])
    }
}
