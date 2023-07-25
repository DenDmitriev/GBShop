//
//  UserView.swift
//  GBShop
//
//  Created by Denis Dmitriev on 03.07.2023.
//

import SwiftUI

struct UserView: View {
    
    @ObservedObject private var viewModel: UserViewModel
    @State private var isEditing: Bool = false
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
        NavigationStack {
            List {
                Section {
                    TextField("Your name", text: $name)
                        .onChange(of: name) { _ in
                            viewModel.isUpdate = name != UserSession.shared.user?.name
                        }
                        .disabled(!isEditing)
                        .focused($isFocused)
                    TextField("Email", text: $email)
                        .textContentType(.emailAddress)
                        .onChange(of: email) { _ in
                            viewModel.isUpdate = name != UserSession.shared.user?.email
                        }
                        .disabled(!isEditing)
                        .focused($isFocused)
                    TextField("Credit card number", text: $creditCard)
                        .textContentType(.emailAddress)
                        .onChange(of: creditCard) { _ in
                            viewModel.isUpdate = name != UserSession.shared.user?.creditCard
                        }
                        .disabled(!isEditing)
                        .focused($isFocused)
                }
                
                Section {
                    NavigationLink {
                        SecureView(viewModel: SecureViewModel())
                    } label: {
                        Text("Secure")
                    }
                }
                
                Section {
                    Button {
                        viewModel.logout()
                    } label: {
                        Text("Logout")
                            .foregroundColor(.red)
                    }
                }
            }
            .toolbar {
                ToolbarItem {
                    Button {
                        if isEditing {
                            viewModel.updateUserData(name: name,
                                                     email: email,
                                                     creditCard: creditCard)
                        }
                        isEditing.toggle()
                    } label: {
                        Text(isEditing ? "Save" : "Edit")
                    }
                    .disabled(!viewModel.isUpdate && isEditing)
                }
            }
        }
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView()
    }
}
