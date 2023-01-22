//
//  LoginViewModel.swift
//  ChatsApp
//
//  Created by Enes Sancar on 22.01.2023.
//

import Foundation

struct LoginViewModel {
    var emailTextField: String?
    var passwordTextField: String?
    var status: Bool {
        return emailTextField?.isEmpty == false && passwordTextField?.isEmpty == false 
    }
}
