//
//  RegistrationViewModel.swift
//  GBShop
//
//  Created by Denis Dmitriev on 03.07.2023.
//

import Foundation
import SwiftUI

class RegistrationViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var errorMessage: String = ""
    @Published var userMessage: String = ""
    
    private let requestFactory = RequestFactory()
    
    // MARK: - Initialization
    
    // MARK: - Functions
    
    func registration(create: User.Create, isShowing: Binding<Bool>) {
        let authRequests = requestFactory.makeAuthRequestFatory()
        authRequests.registerUser(create: create) { response in
            switch response.result {
            case .success(let result):
                DispatchQueue.main.async {
                    if result.result == .zero {
                        self.errorMessage = result.errorMessage ?? ""
                    } else {
                        self.userMessage = result.userMessage ?? ""
                        isShowing.wrappedValue.toggle()
                    }
                }
                
            case .failure(let error):
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    // MARK: - Private functions
    
}
