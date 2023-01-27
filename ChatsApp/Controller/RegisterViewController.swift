//
//  RegisterViewController.swift
//  ChatsApp
//
//  Created by Enes Sancar on 22.01.2023.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage

class RegisterViewController: UIViewController {
    
    //MARK: - Properties
    private var viewModel = RegisterViewModel()
    private var profileImageToUpload: UIImage?
    
    private lazy var addCameraButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.setImage(UIImage(systemName: "camera.circle"), for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.addTarget(self, action: #selector(handlePhoto), for: .touchUpInside)
        return button
    }()
    
    private lazy var emailContainerView: UIView = {
        let containerView = AuthenticationInputView(image: UIImage(systemName: "envelope")!, textField: emailTextField)
        return containerView
    }()
    
    private lazy var nameContainerView: AuthenticationInputView = {
        let containerView = AuthenticationInputView(image: UIImage(systemName: "person")!, textField: nameTextField)
        return containerView
    }()
    
    private lazy var usernameContainerView: AuthenticationInputView = {
       let containerView = AuthenticationInputView(image: UIImage(systemName: "person")!, textField: usernameTextField)
        return containerView
    }()
    
    private lazy var passwordContainerView: UIView = {
        let containerView = AuthenticationInputView(image: UIImage(systemName: "lock")!, textField: passwordTextField)
        return containerView
    }()
    
    private let emailTextField = CustomTextField(placeHolder: "Email")
    private let nameTextField = CustomTextField(placeHolder: "Name")
    private let usernameTextField = CustomTextField(placeHolder: "Username")
    private let passwordTextField: CustomTextField = {
        let textField = CustomTextField(placeHolder: "Password")
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private var stackView = UIStackView()
    
    private lazy var registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Register", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        button.isEnabled = false
        button.layer.cornerRadius = 8
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title3 )
        button.addTarget(self, action: #selector(handleRegisterButton), for: .touchUpInside )
        return button
    }()
    
    private lazy var switchToLoginPage: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSAttributedString(string: "If you are a member, Login Page", attributes: [.foregroundColor: UIColor.white, .font: UIFont.boldSystemFont(ofSize: 14)])
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(handleToLoginView), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
}

//MARK: - Selector
extension RegisterViewController {
    
    @objc private func handleRegisterButton(_ sender: UIButton) {
        guard let emailText = emailTextField.text else {return}
        guard let nameText = nameTextField.text else {return}
        guard let userNameText = usernameTextField.text else {return}
        guard let passwordText = passwordTextField.text else {return}
        guard let profileImage = profileImageToUpload else {return}
        
        let user = AuthenticationServiceUser(emailText: emailText, passwordText: passwordText, nameText: nameText, userNameText: userNameText)
        AuthenticationService.register(withUser: user, image: profileImage) { error in
            if let error = error{
                print("Error: \(error.localizedDescription)")
                return
            }
            self.dismiss(animated: true) // başarılı ise register ekranını aşşağı indir
        }
    }
    
    @objc private func handleTextFieldChange(_ sender: UITextField) {
        if sender == emailTextField {
            viewModel.email = sender.text
        } else if sender == nameTextField {
            viewModel.name = sender.text
        } else if sender == usernameTextField {
            viewModel.userName = sender.text
        } else {
            viewModel.password = sender.text
        }
        registerButtonStatus()
    }
    
    @objc private func handleToLoginView(_ sender: UIButton) {
        let controller = LoginViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc private func handlePhoto(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        self.present(imagePicker, animated: true)
    }
}

//MARK: - Helpers
extension RegisterViewController {
    
    private func registerButtonStatus () {
        if viewModel.status {
            registerButton.isEnabled = true
            registerButton.backgroundColor = .systemBlue
        } else {
            registerButton.isEnabled = false
            registerButton.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        }
    }
    
    private func style() {
        configureGradientLayer()
        self.navigationController?.navigationBar.isHidden = true
        
        addCameraButton.translatesAutoresizingMaskIntoConstraints = false
        
        stackView = UIStackView(arrangedSubviews: [emailContainerView, nameContainerView, usernameContainerView, passwordContainerView,  registerButton])
        stackView.axis = .vertical
        stackView.spacing = 14
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        emailTextField.addTarget(self, action: #selector(handleTextFieldChange), for: .editingChanged)
        nameTextField.addTarget(self, action: #selector(handleTextFieldChange), for: .editingChanged)
        usernameTextField.addTarget(self, action: #selector(handleTextFieldChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(handleTextFieldChange), for: .editingChanged)
        
        switchToLoginPage.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func layout() {
        view.addSubview(addCameraButton)
        view.addSubview(stackView)
        view.addSubview(switchToLoginPage)
        
        NSLayoutConstraint.activate([
            addCameraButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            addCameraButton.heightAnchor.constraint(equalToConstant: 150),
            addCameraButton.widthAnchor.constraint(equalToConstant: 150),
            addCameraButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            stackView.topAnchor.constraint(equalTo: addCameraButton.bottomAnchor, constant: 32),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            emailContainerView.heightAnchor.constraint(equalToConstant: 50),
            // birine vermek yetiyo çünkü stack viewde otomatik eşit mesafe verdik
            
            switchToLoginPage.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            switchToLoginPage.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20)
        ])
    }
}

//MARK: - UIIMagePickerController
extension RegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else {
            return
        }
        self.profileImageToUpload = image
        
        addCameraButton.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
        addCameraButton.layer.cornerRadius = 150 / 2
        addCameraButton.clipsToBounds = true
        addCameraButton.layer.borderColor = UIColor.white.cgColor
        addCameraButton.layer.borderWidth = 2
        addCameraButton.contentMode = .scaleAspectFill
        dismiss(animated: true)
    }
}
