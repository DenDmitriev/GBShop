//
//  AuthViewModel.swift
//  GBShop
//
//  Created by Denis Dmitriev on 02.07.2023.
//

import Foundation

class AuthViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var userMessage: String?
    @Published var errorMessage: String?
    
    private let requestFactory = RequestFactory()
    
    // MARK: - Initialization
    
    // MARK: - Functions
    
    func loginNew(login: String, password: String) async {
        let requestModel = AuthRequest.LoginUser(
            baseUrl: URL(string: "baseUrl")!,
            headers: [.authorization(username: login, password: password)],
            email: login,
            password: password
        )
        let result = await AuthAPI.login(router: requestModel)
        
        switch result {
        case .success(let success):
            await MainActor.run {
                self.createSession(by: success)
            }
        case .failure(let failure):
            await MainActor.run {
                self.errorMessage = failure.localizedDescription
            }
        }
    }
    
    func createSession(by login: User.Login?) {
        try? UserSession.shared.auth(login: login)
    }
    
    // MARK: - Private functions
    
}
