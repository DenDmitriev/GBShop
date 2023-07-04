//
//  UserViewModel.swift
//  GBShop
//
//  Created by Denis Dmitriev on 03.07.2023.
//

import Foundation

class UserViewModel: ObservableObject {
    
    let requestFactory = RequestFactory()
    @Published var isUpdate: Bool
    
    init() {
        self.isUpdate = false
    }
    
    func logout() {
        let auth = requestFactory.makeAuthRequestFatory()
        guard let id = UserSession.shared.user?.id else {
            return
        }
        auth.logout(userId: id) { response in
            switch response.result {
            case .success(let logout):
                if logout.result != .zero {
                    self.endSession()
                } else {
                    print(logout.errorMessage ?? "")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func update(name: String, email: String, creditCard: String) {
        let auth = requestFactory.makeAuthRequestFatory()
        if let user = UserSession.shared.user {
            let update: User.Update = .init(id: user.id, name: name, email: email, creditCard: creditCard)
            auth.changeUserData(update: update) { response in
                switch response.result {
                case .success(let updateResult):
                    if
                        updateResult.result != .zero,
                        let user = updateResult.user
                    {
                        self.updateUserDataSession(user: user)
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
    
    private func endSession() {
        try? UserSession.shared.close()
    }
    
    private func updateUserDataSession(user: User) {
        UserSession.shared.user = user
    }
}
