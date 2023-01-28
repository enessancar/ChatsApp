//
//  Service.swift
//  ChatsApp
//
//  Created by Enes Sancar on 28.01.2023.
//

import Foundation
import FirebaseFirestore

struct Service {
    static func fetchUsers(completion: @escaping([User]) -> Void) {
        var users = [User]()
        Firestore.firestore().collection("users").getDocuments { snapshot, error in
            if let error = error {
                print("ERROR: \(error.localizedDescription)")
            }
            users = snapshot?.documents.map({ User(data: $0.data())}) ?? []
            completion(users)
        }
    }
}
