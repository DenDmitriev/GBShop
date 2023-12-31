//
//  AuthView.swift
//  GBShop
//
//  Created by Denis Dmitriev on 02.07.2023.
//

import SwiftUI

struct AuthView: View {

    @ObservedObject var viewModel: AuthViewModel
    @State private var login: String = "" // "test@vapor.codes"
    @State private var password: String = "" // "secret42"
    @State private var userMessage: String = "Hello, there!👋"
    @State private var errorMessage: String = ""
    @State private var isLoading: Bool = false

    @FocusState var isEmailFocused: Bool
    @FocusState var isPasswordFocused: Bool

    @State var isRegistration: Bool = false

    init() {
        self.viewModel = AuthViewModel()
    }

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Spacer()
                    .frame(maxHeight: .infinity)

                Text(userMessage)
                    .font(.largeTitle)
                    .onReceive(viewModel.$userMessage) { message in
                        if let message = message {
                            self.userMessage = message
                        }
                    }

                VStack(spacing: 16) {
                    TextField("Login", text: $login)
                        .textContentType(.emailAddress)
                        .font(.title3)
                        .focused($isEmailFocused)
                        .onSubmit {
                            isEmailFocused.toggle()
                            isPasswordFocused.toggle()
                        }
                        .accessibilityIdentifier("email")

                    SecureField("Password", text: $password)
                        .textContentType(.password)
                        .font(.title3)
                        .focused($isPasswordFocused)
                        .onSubmit {
                            isPasswordFocused.toggle()
                        }
                        .accessibilityIdentifier("password")

                    HStack {
                        Button {
                            Task {
                                isLoading = true
                                await viewModel.loginNew(login: login, password: password)
                                isLoading = false
                            }
                        } label: {
                            HStack {
                                if isLoading {
                                    ProgressView()
                                }
                                
                                Text("Login")
                            }
                            
                        }
                        .accessibilityIdentifier("login")
                        .disabled(isLoading)
                        .buttonStyle(.borderedProminent)
                        .font(.headline)

                        NavigationLink("Registration") {
                            RegistrationView()
                                .navigationTitle("Registration")
                                .navigationBarTitleDisplayMode(.large)
                        }
                        .disabled(isLoading)
                        .buttonStyle(.bordered)
                        .font(.headline)

                        Spacer()
                    }
                }

                Text(errorMessage)
                    .foregroundColor(.red)
                    .frame(maxHeight: .infinity, alignment: .topTrailing)
                    .onReceive(viewModel.$errorMessage) { message in
                        if let message = message {
                            self.errorMessage = message
                        }
                    }
            }
            .navigationTitle("Sign In")
            .navigationBarTitleDisplayMode(.large)
            .padding(.horizontal, 32.0)
        }
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}
