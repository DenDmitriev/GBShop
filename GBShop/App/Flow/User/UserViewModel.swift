//
//  UserViewModel.swift
//  GBShop
//
//  Created by Denis Dmitriev on 03.07.2023.
//

import Foundation

class UserViewModel: ObservableObject {
    
    // MARK: - Properties
    
    private let requestFactory = RequestFactory()
    @Published var isUpdate: Bool
    
    // MARK: - Initialization
    
    init() {
        self.isUpdate = false
    }
    
    // MARK: - Functions
    
    func logout() {
        let authRequests = requestFactory.makeAuthRequestFatory()
        guard let id = UserSession.shared.user?.id else {
            return
        }
        authRequests.logout(userId: id) { response in
            switch response.result {
            case .success(let logout):
                if logout.result != .zero {
                    self.closeSession()
                } else {
                    print(logout.errorMessage ?? "")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func updateUserData(name: String, email: String, creditCard: String) {
        let authRequests = requestFactory.makeAuthRequestFatory()
        if let user = UserSession.shared.user {
            let update: User.Update = .init(id: user.id, name: name, email: email, creditCard: creditCard)
            authRequests.changeUserData(update: update) { response in
                switch response.result {
                case .success(let updateResult):
                    if
                        updateResult.result != .zero,
                        let user = updateResult.user
                    {
                        self.updateUserDataInSession(user: user)
                        DispatchQueue.main.async {
                            self.isUpdate = false
                        }
                    } else {
                        print(updateResult.errorMessage ?? "")
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        
    }
    
    // MARK: - Private functions
    
    private func closeSession() {
        try? UserSession.shared.close()
    }
    
    private func updateUserDataInSession(user: User) {
        UserSession.shared.user = user
    }
}
