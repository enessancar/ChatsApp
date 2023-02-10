//
//  MessageViewModel.swift
//  ChatsApp
//
//  Created by Enes Sancar on 9.02.2023.
//

import Foundation

struct MessageViewModel {
    
    private let lastUser: LastUser
    init(lastUser: LastUser) {
        self.lastUser = lastUser
    }
    
    var profileImage: URL? {
        return URL(string: lastUser.user.profileImageUrl)
    }
    
    var timestampString: String {
        let date = lastUser.message.timeStamp.dateValue()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd:mm a"
        return dateFormatter.string(from: date)
    }
}
