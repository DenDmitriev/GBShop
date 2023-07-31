//
//  UserCoordinator.swift
//  GBShop
//
//  Created by Denis Dmitriev on 27.07.2023.
//

import SwiftUI

class UserCoordinator: ObservableObject {
    
    @Published var path = NavigationPath()
    
    @Published var page: UserPage?
    
    func push(_ page: UserPage) {
        path.append(page)
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
    
    @ViewBuilder
    func build(page: UserPage) -> some View {
        switch page {
        case .user:
            UserView(viewModel: UserViewModel())
        case .secure:
            SecureView(viewModel: SecureViewModel())
        }
    }
}
