//
//  RegistrationView.swift
//  GBShop
//
//  Created by Denis Dmitriev on 02.07.2023.
//

import SwiftUI

struct RegistrationView: View {
    
    @ObservedObject private var viewModel = RegistrationViewModel()
    
    @Binding var isShowing: Bool
    
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var creditCard: String = ""
    
    @State private var userMessage: String = "Fill fields ✍️"
    @State private var errorMessage: String = ""
    
    @FocusState var isNameFocused: Bool
    @FocusState var isEmailFocused: Bool
    @FocusState var isPasswordFocused: Bool
    @FocusState var isConfirmPasswordFocused: Bool
    @FocusState var isCreditCardFocused: Bool
    
    @State private var isRegisterAllow: Bool = false
    
    var body: some View {
        VStack {
            Spacer()
                .frame(maxHeight: .infinity)
            
            VStack(alignment: .leading, spacing: 16) {
                Text(userMessage)
                    .font(.largeTitle)
                
                TextField("Your name", text: $name)
                    .focused($isNameFocused)
                    .onSubmit {
                        isNameFocused.toggle()
                        isEmailFocused.toggle()
                    }
                TextField("Email", text: $email)
                    .focused($isEmailFocused)
                    .onSubmit {
                        isEmailFocused.toggle()
                        isPasswordFocused.toggle()
                    }
                    .textContentType(.emailAddress)
                SecureField("Password", text: $password)
                    .focused($isPasswordFocused)
                    .onSubmit {
                        isPasswordFocused.toggle()
                        isConfirmPasswordFocused.toggle()
                    }
                    .textContentType(.password)
                SecureField("Confirm password", text: $confirmPassword)
                    .focused($isConfirmPasswordFocused)
                    .onSubmit {
                        isConfirmPasswordFocused.toggle()
                        isCreditCardFocused.toggle()
                    }
                    .textContentType(.password)
                TextField("Credit card number", text: $creditCard)
                    .focused($isCreditCardFocused)
                    .onSubmit {
                        isCreditCardFocused.toggle()
                    }
                    .textContentType(.emailAddress)
                
                Button("Register") {
                    let create = User.Create(name: name,
                                             email: email.lowercased(),
                                             password: password,
                                             confirmPassword: password,
                                             creditCard: creditCard)
                    viewModel.registration(create: create, isShowing: $isShowing)
                }
                .buttonStyle(.borderedProminent)
                .font(.headline)
            }
            
            HStack {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .frame(maxHeight: .infinity, alignment: .topLeading)
                    .onReceive(viewModel.$message) { message in
                        if let message = message {
                            self.errorMessage = message
                        }
                }
                
                Spacer()
            }
        }
        .padding(.horizontal, 32.0)
    }
}

struct Registration_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView(isShowing: Binding<Bool>.constant(true))
    }
}
