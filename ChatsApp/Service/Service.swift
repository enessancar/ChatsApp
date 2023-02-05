//
//  Service.swift
//  ChatsApp
//
//  Created by Enes Sancar on 28.01.2023.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

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
    
    static func fetchUser(uid: String, completion: @escaping(User) -> Void) {
        Firestore.firestore().collection("users").document(uid).getDocument { snapshot, error in
            guard let data = snapshot?.data() else { return }
            let user = User(data: data)
            completion(user)
        }
    }
    
    static func fethLastUsers(completion: @escaping([LastUser]) -> Void) {
        var lastUsers = [LastUser]()
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        Firestore.firestore().collection("messages").document(uid).collection("last-messages").order(by: "timestamp").addSnapshotListener { snapshot, error in
            <#code#>
        }
        
    }
    
    static func sendMessage(message: String, toUser: User, completion: @escaping(Error?) -> Void) {
        guard let currentUid = Auth.auth().currentUser?.uid  else { return }
        let data = [
            "text": message,
            "fromId": currentUid,
            "toId": toUser.uid,                    // göndereceğimiz kişi
            "timestamp": Timestamp(date: Date())
        ] as [String: Any]
        
        Firestore.firestore().collection("messages").document(currentUid).collection(toUser.uid).addDocument(data: data) { error in
            
            Firestore.firestore().collection("messages").document(toUser.uid).collection(currentUid).addDocument(data: data)
            
            Firestore.firestore().collection("messages").document(currentUid).collection("last-messages").document(toUser.uid).setData(data)
            
            Firestore.firestore().collection("messages").document(toUser.uid).collection("last-messages").document(currentUid).setData(data)
        }
    }
    
    static func fetchMessages(user: User, completion: @escaping([Message]) -> Void) {
        var messages = [Message]()
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        Firestore.firestore().collection("messages").document(currentUid).collection(user.uid).order(by: "timestamp").addSnapshotListener { snapshot, error in
            snapshot?.documentChanges.forEach({ value in
                if value.type == .added {
                    let data = value.document.data()
                    messages.append(Message(data: data))
                    completion(messages)
                }
            })
        }
    }
}
