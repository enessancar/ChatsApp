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
    private let messageViewController = NewMessageViewController()
    private lazy var viewControllers: [UIViewController] = [MessageViewController(), messageViewController]
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        authenticationStatus ()
        style()
        layout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        handleMessageButton()
    }
}

//MARK: - Helpers
extension HomeViewController {
    
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
        }
    }
    
    private func style() {
        view.backgroundColor = .systemBackground
        
        messageButton = UIBarButtonItem(customView: configureBarItem(text: "Message", selector: #selector(handleMessageButton)))
        newMessageButton = UIBarButtonItem(customView: configureBarItem(text: "New Message", selector: #selector(handleNewMessageButton)))
        
        self.navigationItem.leftBarButtonItems = [messageButton, newMessageButton]
        self.messageViewController.delegate = self
        
        // Container
        configureContainer()
        handleMessageButton() // ilk açtığımızda message ekranı gelsin 
    }
    
    private func layout() {
        
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

extension HomeViewController: NewMessageViewControllerProtocol {
    
    func goToChatView(user: User) {
        let controller = ChatViewController(user: user)
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
