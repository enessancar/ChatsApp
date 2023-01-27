//
//  AuthenticationService.swift
//  ChatsApp
//
//  Created by Enes Sancar on 26.01.2023.
//

import UIKit
import FirebaseStorage
import FirebaseFirestore
import FirebaseAuth

struct AuthenticationServiceUser {
    var emailText: String
    var passwordText: String
    var nameText: String
    var userNameText: String
}

struct AuthenticationService {
    static func register(withUser user: AuthenticationServiceUser ,image: UIImage, completion: @escaping(Error?) -> Void) {
        let photoName = UUID().uuidString
        guard let profileData = image.jpegData(compressionQuality: 0.5) else { return }
        let referance = Storage.storage().reference(withPath: "media/profile_image/\(photoName).png")
        referance.putData(profileData) { storageMeta, error in
            if let error = error {
                completion(error)
            }
            referance.downloadURL { url , error in
                if let error = error {
                    completion(error)
                    return
                }
                guard let profileImageUrl = url?.absoluteString else {return}
                
                Auth.auth().createUser(withEmail: user.emailText, password: user.passwordText) { result, error in
                    if let error = error {
                        completion(error)
                        return
                    }
                    guard let userUid = result?.user.uid else { return }
                    let data = [
                        "email": user.emailText,
                        "name": user.nameText,
                        "userName:": user.userNameText,
                        "profileImageUrl": profileImageUrl,
                        "uuid": userUid,
                        
                    ] as [String: Any ]
                    Firestore.firestore().collection("users").document(userUid).setData(data, completion: completion)
                }
            }
        }
    }
}

