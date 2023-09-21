//
//  RegistrationViewModel.swift
//  GBShop
//
//  Created by Denis Dmitriev on 03.07.2023.
//

import Foundation
import SwiftUI
import Firebase

class RegistrationViewModel: ObservableObject {

    // MARK: - Properties

    @Published var errorMessage: String = ""
    @Published var userMessage: String = ""

    private let requestFactory = RequestFactory()

    // MARK: - Initialization

    // MARK: - Functions
    
    func registration(create: User.Create, isPresentation: Binding<PresentationMode>) async {
        let requestModel = AuthRequest.RegisterUser(baseUrl: URL(string: "baseURL")!, create: create)
        let response = await AuthAPI.registerUser(router: requestModel)
        
        switch response {
        case .success(let success):
            await MainActor.run {
                self.userMessage = success.userMessage ?? ""
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    isPresentation.wrappedValue.dismiss()
                }
                Crashlytics.crashlytics().log("Registered, \(create.email)")
            }
        case .failure(let failure):
            await MainActor.run {
                self.errorMessage = failure.localizedDescription
            }
            Crashlytics.crashlytics().record(error: failure)
        }
    }

    // MARK: - Private functions

}
