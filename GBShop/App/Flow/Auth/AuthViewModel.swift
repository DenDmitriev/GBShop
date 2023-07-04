//
//  AuthViewModel.swift
//  GBShop
//
//  Created by Denis Dmitriev on 02.07.2023.
//

import Foundation

class AuthViewModel: ObservableObject {
    
    let requestFactory = RequestFactory()
    @Published var userMessage: String?
    @Published var errorMessage: String?
    
    func login(login: String, password: String) {
        let auth = requestFactory.makeAuthRequestFatory()
        
        auth.login(email: login, password: password) { response in
            switch response.result {
            case .success(let loginResult):
                DispatchQueue.main.async {
                    if loginResult.result == .zero {
                        self.errorMessage = loginResult.errorMessage
                    } else if let login = loginResult.user {
                        self.userMessage = "Welcome, \(login.name)!"
                        self.errorMessage = nil
                        self.createSession(by: login)
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    
    func createSession(by login: User.Login?) {
        try? UserSession.shared.create(login: login)
    }
}