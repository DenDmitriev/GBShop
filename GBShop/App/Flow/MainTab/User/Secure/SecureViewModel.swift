//
//  SecureViewModel.swift
//  GBShop
//
//  Created by Denis Dmitriev on 14.07.2023.
//

import Foundation
import Firebase

class SecureViewModel: ObservableObject {
    
    func updatePassword() {
        Analytics.logEvent("Update password", parameters: nil)
        print("update password")
    }
}
