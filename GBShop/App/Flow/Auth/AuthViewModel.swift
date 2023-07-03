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
            case .success(let login):
                DispatchQueue.main.async {
                    if login.result == .zero {
                        self.errorMessage = login.errorMessage
                    } else if let name = login.user?.name {
                        self.userMessage = "Welcome, \(name)!"
                        self.errorMessage = nil
                        
                        self.createSession(for: login.user)
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    
    func createSession(for user: User?) {
        UserSession.shared.create(user: user)
    }
}
