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
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        signOut()
        style()
        layout()
    }
}

//MARK: - Helpers
extension HomeViewController {
    
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
    }
    
    private func layout() {
        
    }
}
