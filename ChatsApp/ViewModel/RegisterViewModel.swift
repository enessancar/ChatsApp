//
//  RegisterViewModel.swift
//  ChatsApp
//
//  Created by Enes Sancar on 25.01.2023.
//

import Foundation

struct RegisterViewModel {
    var email: String?
    var name: String?
    var userName: String?
    var password: String?
    
    var status: Bool {
        return email?.isEmpty == false && password?.isEmpty == false && userName?.isEmpty == false && name?.isEmpty == false
    }
}

