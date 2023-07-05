//
//  UserView.swift
//  GBShop
//
//  Created by Denis Dmitriev on 03.07.2023.
//

import SwiftUI

struct UserView: View {
    
    @ObservedObject private var viewModel: UserViewModel
    @State private var name: String
    @State private var email: String
    @State private var creditCard: String
    @FocusState private var isFocused: Bool
    
    init() {
        self.viewModel = UserViewModel()
        let user = UserSession.shared.user
        self.name = user?.name ?? ""
        self.email = user?.email ?? ""
        self.creditCard = user?.creditCard ?? ""
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            TextField("Your name", text: $name)
                .onChange(of: name) { newValue in
                    viewModel.isUpdate = name != UserSession.shared.user?.name
                }
                .focused($isFocused)
            TextField("Email", text: $email)
                .textContentType(.emailAddress)
                .onChange(of: email) { newValue in
                    viewModel.isUpdate = name != UserSession.shared.user?.email
                }
                .focused($isFocused)
            TextField("Credit card number", text: $creditCard)
                .textContentType(.emailAddress)
                .onChange(of: creditCard) { newValue in
                    viewModel.isUpdate = name != UserSession.shared.user?.creditCard
                }
                .focused($isFocused)
            
            VStack(alignment: .leading) {
                Button("Save") {
                    viewModel.updateUserData(name: name,
                                     email: email,
                                     creditCard: creditCard)
                    isFocused = false
                }
                .disabled(!viewModel.isUpdate)
                .buttonStyle(.borderedProminent)
                .font(.headline)
                
                Button("Logout") {
                    viewModel.logout()
                }
                .buttonStyle(.bordered)
                .font(.headline)
                
                Button("Secure") {
                    // viewModel.changePassword()
                }
                .buttonStyle(.bordered)
                .font(.headline)
            }
            
        }
        .padding(.horizontal, 32.0)
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView()
    }
}
