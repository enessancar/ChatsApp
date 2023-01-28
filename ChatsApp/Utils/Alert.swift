//
//  Alert.swift
//  ChatsApp
//
//  Created by Enes Sancar on 25.01.2023.
//

import UIKit

extension UIViewController {
    
    func makeAlert(title: String?,  message: String?) {
        let alert = UIAlertController(title: title ?? "ERROR", message: message ?? "ERROR", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(okButton)
        present(alert, animated: true, completion: nil)
    }
}
