//
//  Session.swift
//  GBShop
//
//  Created by Denis Dmitriev on 03.07.2023.
//

import SwiftUI

class UserSession: ObservableObject {
    
    static let shared = UserSession()
    
    @Published var isAuth = false
    
//    var token: String = ""
    var user: User?
    
    func create(user: User?) {
        if let user = user {
            DispatchQueue.main.async {
                self.user = user
                self.isAuth = true
            }
        }
    }
    
    func close() {
        DispatchQueue.main.async {
            self.isAuth = false
            self.user = nil
        }
    }
    
//    var description: String {
//        "User ID: \(id)\nToken: \(token)"
//    }
    
//    func create(_ token: String, _ id: String) {
//        let session = Session.shared
//        session.token = token
//        session.id = id
//        print(description)
//        isUserAutorizated = true
//    }
}
