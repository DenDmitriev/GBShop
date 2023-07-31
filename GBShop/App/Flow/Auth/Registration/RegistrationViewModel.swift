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

    func registration(create: User.Create, isPresentation: Binding<PresentationMode>) {
        let authRequests = requestFactory.makeAuthRequestFactory()
        authRequests.registerUser(create: create) { response in
            switch response.result {
            case .success(let result):
                DispatchQueue.main.async {
                    if result.result == .zero {
                        self.errorMessage = result.errorMessage ?? ""
                    } else {
                        self.userMessage = result.userMessage ?? ""
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                            isPresentation.wrappedValue.dismiss()
                        }
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
