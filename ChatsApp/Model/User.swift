//
//  User.swift
//  ChatsApp
//
//  Created by Enes Sancar on 28.01.2023.
//

import Foundation

struct User {
    let uid: String
    let name: String
    let userName: String
    let email: String
    let profileImageUrl: String
    
    init(data: [String: Any]) {
        self.uid = data["uid"] as? String ?? ""
        self.name = data["name"] as? String ?? ""
        self.userName = data["userName"] as? String ?? ""
        self.email = data["email"] as? String ?? ""
        self.profileImageUrl = data["profileImageUrl"] as? String ?? ""
    }
}
