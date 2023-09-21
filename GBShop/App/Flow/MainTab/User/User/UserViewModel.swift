//
//  UserViewModel.swift
//  GBShop
//
//  Created by Denis Dmitriev on 03.07.2023.
//

import Foundation
import Firebase

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
        let authRequests = requestFactory.makeAuthRequestFactory()
        guard let id = UserSession.shared.user?.id else {
            return
        }
        
        Analytics.logEvent("Logout", parameters: [
            AnalyticsParameterItemID: id,
            "email": UserSession.shared.user?.email ?? "nil"
        ])
        
        authRequests.logout(userId: id) { response in
            switch response.result {
            case .success(let logout):
                if logout.result != .zero {
                    self.closeSession()
                    Crashlytics.crashlytics().log("logout")
                } else {
                    print(logout.errorMessage ?? "")
                    Crashlytics.crashlytics().log(logout.errorMessage ?? "Logout error")
                }
            case .failure(let error):
                print(error.localizedDescription)
                Crashlytics.crashlytics().record(error: error)
            }
        }
    }

    func updateUserData(name: String, email: String, creditCard: String) {
        let authRequests = requestFactory.makeAuthRequestFactory()
        
        Analytics.logEvent("UpdateUserData", parameters: [
            "email": email
        ])
        
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
                        Crashlytics.crashlytics().log("updated user data")
                    } else {
                        let errorMessage = updateResult.errorMessage ?? ""
                        print(errorMessage)
                        Crashlytics.crashlytics().log(errorMessage)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    Crashlytics.crashlytics().record(error: error)
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
