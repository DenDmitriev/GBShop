//
//  SecureView.swift
//  GBShop
//
//  Created by Denis Dmitriev on 14.07.2023.
//

import SwiftUI

struct SecureView: View {
    
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
        .toolbar {
            ToolbarItem {
                Button {
                    viewModel.updatePassword()
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
