//
//  GBShopAppViewModel.swift
//  GBShop
//
//  Created by Denis Dmitriev on 05.07.2023.
//

import Foundation

class GBShopAppViewModel: ObservableObject {

    // MARK: - Properties

    private let requestFactory = RequestFactory()

    // MARK: - Initialization

    init() {
        checkAuthByToken()
    }

    // MARK: - Functions

    func checkAuthByToken() {
        guard let token = getToken() else { return }
        let authRequests = requestFactory.makeAuthRequestFactory()
        authRequests.me(token: token) { response in
            switch response.result {
            case .success(let result):
                guard let userPublic = result.user else { return }
                self.createSession(by: userPublic, with: token)
            case .failure(let error):
                print(error.localizedDescription)
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
