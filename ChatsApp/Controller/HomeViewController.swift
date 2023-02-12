//
//  HomeViewController.swift
//  ChatsApp
//
//  Created by Enes Sancar on 26.01.2023.
//

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController {
 
    //MARK: - Properties
    private var messageButton: UIBarButtonItem!
    private var newMessageButton: UIBarButtonItem!
    private var container = ContainerViewController()
    private let newMessageViewController = NewMessageViewController()
    private let messageViewConroller = MessageViewController()
    private lazy var viewControllers: [UIViewController] = [messageViewConroller, newMessageViewController]
    private let profileView = ProfileView()
    private var isProfileViewActive: Bool = false
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        authenticationStatus ()
        style()
        layout()
        fetchUser()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        handleMessageButton()
    }
}

//MARK: - Helpers
extension HomeViewController {
    
    private func fetchUser() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Service.fetchUser(uid: uid) { user in
            self.profileView.user = user
        }
    }
    
    private func configureBarItem(text: String, selector: Selector) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(text, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        button.addTarget(self, action: selector, for: .touchUpInside)
        return button
    }
    
    private func authenticationStatus() {
        if Auth.auth().currentUser?.uid == nil {
            DispatchQueue.main.async {
                let controller = UINavigationController(rootViewController: LoginViewController())
                controller.modalPresentationStyle = .fullScreen
                self.present(controller, animated: true)
            }
        }
    }
    
    private func signOut() {
        do {
            try Auth.auth().signOut()
            authenticationStatus()
        } catch {
            fatalError("Error")
        }
    }
    
    private func style() {
        view.backgroundColor = .white
        self.navigationController?.navigationBar.tintColor = .white
        
        messageButton = UIBarButtonItem(customView: configureBarItem(text: "Message", selector: #selector(handleMessageButton)))
        newMessageButton = UIBarButtonItem(customView: configureBarItem(text: "New Message", selector: #selector(handleNewMessageButton)))
        
        self.navigationItem.leftBarButtonItems = [messageButton, newMessageButton]
        self.newMessageViewController.delegate = self
        self.messageViewConroller.delegate = self
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: #selector(handleProfileButton))
        
        profileView.translatesAutoresizingMaskIntoConstraints = false
        profileView.layer.cornerRadius = 20
        profileView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner] // sol üst/alt
        profileView.delegate = self
        
        // Container
        configureContainer()
        handleMessageButton() // ilk açtığımızda message ekranı gelsin 
    }
    
    private func layout() {
        view.addSubview(profileView)
        NSLayoutConstraint.activate([
            profileView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            profileView.leadingAnchor.constraint(equalTo: view.trailingAnchor),
            profileView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            profileView.widthAnchor.constraint(equalToConstant: view.frame.width * 0.6)
        ])
    }
    
    private func configureContainer() {
        guard let containerView = container.view else { return }
        containerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

//MARK: -  Selector
extension HomeViewController {
    
    @objc private func handleProfileButton(_ sender: UIBarButtonItem) {
        UIView.animate(withDuration: 0.5) {
            if self.isProfileViewActive {
                self.profileView.frame.origin.x =  self.view.frame.width
            }
            else {
                self.profileView.frame.origin.x = self.view.frame.width * 0.4
            }
        }
        self.isProfileViewActive.toggle()
    }
    
    @objc private func handleMessageButton() {
        if self.container.children.first == MessageViewController() { return }
        self.messageButton.customView?.alpha = 1
        self.newMessageButton.customView?.alpha = 0.5
        self.container.add( viewControllers[0])
        viewControllers[1].remove()
    }
    
    @objc private func handleNewMessageButton() {
        if self.container.children.first == NewMessageViewController() { return }
        self.messageButton.customView?.alpha = 0.5
        self.newMessageButton.customView?.alpha = 1 
        self.container.add(viewControllers[1])
        viewControllers[0].remove()
    }
}

//MARK: - NewMessageViewControllerProtocol
extension HomeViewController: NewMessageViewControllerProtocol {
    
    func goToChatView(user: User) {
        let controller = ChatViewController(user: user)
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

//MARK: - MessageViewControllerProtocol
extension HomeViewController: MessageViewControllerProtocol {
   
    func showChatViewController(_ messageViewController: MessageViewController, user: User) {
        let controller = ChatViewController(user: user)
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

//MARK: - ProfileViewProtocol
extension HomeViewController: ProfileViewProtocol {
    func signOutProfile() {
        self.signOut()
    }
}
