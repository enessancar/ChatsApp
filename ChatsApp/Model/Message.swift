//
//  Message.swift
//  ChatsApp
//
//  Created by Enes Sancar on 31.01.2023.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

struct Message {
    let text: String
    let toId: String
    let fromId: String
    var timeStamp: Timestamp!
    var user: User?
    let currentUser: Bool
    
    init(data: [String: Any]) {
        self.text = data["text"] as? String ?? ""
        self.toId = data["toId"] as? String ?? ""
        self.fromId = data["fromId"] as? String ?? ""
        self.timeStamp = data["timeStamp"] as? Timestamp ?? Timestamp(date: Date())
        self.currentUser = fromId == Auth.auth().currentUser?.uid
    }
}
