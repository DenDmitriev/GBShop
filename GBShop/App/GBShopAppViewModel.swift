//
//  GBShopAppViewModel.swift
//  GBShop
//
//  Created by Denis Dmitriev on 05.07.2023.
//

import Foundation

class GBShopAppViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var hasError: Bool = false
    @Published var error: APIError?
    private let requestFactory = RequestFactory()
    
    // MARK: - Initialization
    
    // MARK: - Functions
    
    func authWithToken() async {
        guard let token = getToken() else { return }
        let requestModel = AuthRequest.LoginUserWithToken(
            baseUrl: URL(string: "baseUrl")!,
            headers: [.authorization(bearerToken: token)]
        )
        let result = await AuthAPI.me(router: requestModel)
        
        switch result {
        case .success(let success):
            self.createSession(by: success, with: token)
        case .failure(let failure):
            await MainActor.run {
                self.error = APIError.error(message: failure.localizedDescription)
                self.hasError = true
            }
        }
    }
    
    // MARK: - Private functions
    
    private func getToken() -> String? {
        let secureStore = SecureStore()
        let userName = UserDefaultsStore.userName
        do {
            let token = try secureStore.getValue(for: userName)
            return token
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }
    
    private func createSession(by publicUser: User.Public, with token: String) {
        do {
            try UserSession.shared.create(user: User(from: publicUser), token: token)
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
