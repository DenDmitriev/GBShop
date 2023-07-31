//
//  UserCoordinatorView.swift
//  GBShop
//
//  Created by Denis Dmitriev on 27.07.2023.
//

import SwiftUI

struct UserCoordinatorView: View {
    
    @StateObject private var coordinator = UserCoordinator()
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            coordinator.build(page: .user)
                .navigationBarTitle("Me 👤")
                .navigationDestination(for: UserPage.self) { page in
                    coordinator.build(page: page)
                }
        }
        .environmentObject(coordinator)
    }
}

struct UserCoordinatorView_Previews: PreviewProvider {
    static var previews: some View {
        UserCoordinatorView()
    }
}
