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
    let secureStore = SecureStore()
    
    var token: String = ""
    var user: User?
    
    func create(login: User.Login?) throws {
        if let login = login {
            DispatchQueue.main.async {
                self.user = User(from: login)
                self.token = login.token
                self.isAuth = true
            }
            saveUserName(name: login.name)
            try saveToken(token: login.token, for: login.name)
        }
    }
    
    func create(user: User, token: String) throws {
        DispatchQueue.main.async {
            self.user = user
            self.token = token
            self.isAuth = true
        }
        saveUserName(name: user.name)
        try saveToken(token: token, for: user.name)
    }
    
    func close() throws {
        DispatchQueue.main.async {
            self.isAuth = false
            self.user = nil
            self.token = ""
        }
        try deleteToken()
    }
    
    // MARK: - Private
    
    private func saveUserName(name: String) {
        UserDefaultsHelper.userName = name
    }
    
    private func saveToken(token: String, for userName: String) throws {
        try secureStore.setValue(token, for: userName)
    }
    
    private func deleteToken() throws {
        if let name = user?.name {
            try secureStore.removeValue(for: name)
        }
    }
}
