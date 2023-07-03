//
//  RegistrationViewModel.swift
//  GBShop
//
//  Created by Denis Dmitriev on 03.07.2023.
//

import Foundation

class RegistrationViewModel: ObservableObject {
    
    let requestFactory = RequestFactory()
    @Published var message: String?
    
    func registration(create: User.Create) {
        let auth = requestFactory.makeAuthRequestFatory()
        auth.registerUser(create: create) { response in
            switch response.result {
            case .success(let result):
                DispatchQueue.main.async {
                    if result.result == .zero {
                        self.message = result.errorMessage
                    } else {
                        self.message = result.userMessage
                    }
                }
                
            case .failure(let error):
                DispatchQueue.main.async {
                    self.message = error.localizedDescription
                }
            }
        }
    }
}
