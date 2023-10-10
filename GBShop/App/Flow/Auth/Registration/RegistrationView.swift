//
//  RegistrationView.swift
//  GBShop
//
//  Created by Denis Dmitriev on 02.07.2023.
//

import SwiftUI

struct RegistrationView: View {

    @ObservedObject private var viewModel = RegistrationViewModel()

    @Environment(\.presentationMode) var isPresentation

    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var creditCard: String = ""

    @State private var userMessage: String = "Fill fields ✍️"
    @State private var colorErrorMessage: Color = .red
    @State private var errorMessage: String = ""

    @FocusState private var isNameFocused: Bool
    @FocusState private var isEmailFocused: Bool
    @FocusState private var isPasswordFocused: Bool
    @FocusState private var isConfirmPasswordFocused: Bool
    @FocusState private var isCreditCardFocused: Bool

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
                    Task {
                        await viewModel.registration(create: create, isPresentation: isPresentation)
                    }
                }
                .buttonStyle(.borderedProminent)
                .font(.headline)
            }
            
            HStack {
                Text(errorMessage)
                    .foregroundColor(colorErrorMessage)
                    .frame(maxHeight: .infinity, alignment: .topLeading)
                    .onReceive(viewModel.$errorMessage) { message in
                        self.errorMessage = message
                        self.colorErrorMessage = .red
                }
                    .onReceive(viewModel.$userMessage) { message in
                        self.errorMessage = message
                        self.colorErrorMessage = .green
                    }

                Spacer()
            }
        }
        .padding(.horizontal, 32.0)
    }
}

struct Registration_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
