//
//  ProfileView.swift
//  ChatsApp
//
//  Created by Enes Sancar on 2.02.2023.
//

import UIKit
import FirebaseAuth

class ProfileView: UIView {
    
    //MARK: - Properties
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

//MARK: - Helpers
extension ProfileView {
    
    private func style() {
        
    }
    
    private func layout() {
        
    }
    
    private func fetchUser() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Service.fetchUser(uid: uid) { user in
            print(user.userName)
        }
    }
}
