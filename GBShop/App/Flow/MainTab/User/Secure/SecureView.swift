//
//  SecureView.swift
//  GBShop
//
//  Created by Denis Dmitriev on 14.07.2023.
//

import SwiftUI

struct SecureView: View {
    
    @EnvironmentObject var coordinator: UserCoordinator
    @ObservedObject var viewModel: SecureViewModel
    @State var oldPassword: String = ""
    @State var newPassword: String = ""
    @State var confirmNewPassword: String = ""
    
    var body: some View {
        List {
            Section {
                TextField("Old password", text: $oldPassword)
                    .textContentType(.password)
            }
            
            Section {
                TextField("New password", text: $newPassword)
                    .textContentType(.newPassword)
                TextField("Confirm new password", text: $confirmNewPassword)
                    .textContentType(.newPassword)
            }
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    coordinator.pop()
                } label: {
                    Image(systemName: "chevron.backward")
                }

            }
            
            ToolbarItem {
                Button {
                    viewModel.updatePassword()
                    coordinator.pop()
                } label: {
                    Text("Update")
                }
            }
        }
    }
}

struct SecureView_Previews: PreviewProvider {
    static var previews: some View {
        SecureView(viewModel: SecureViewModel())
    }
}
