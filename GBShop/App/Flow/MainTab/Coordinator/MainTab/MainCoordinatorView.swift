//
//  MainCoordinatorView.swift
//  GBShop
//
//  Created by Denis Dmitriev on 26.07.2023.
//

import SwiftUI

struct MainCoordinatorView: View {
    
    @StateObject private var coordinator = MainTabCoordinator()
    
    var body: some View {
        TabView(selection: $coordinator.tab) {
            coordinator.build(tab: .catalog)
            coordinator.build(tab: .basket)
            coordinator.build(tab: .user)
        }
        .environmentObject(coordinator)
    }
}

struct MainCoordinatorView_Previews: PreviewProvider {
    static var previews: some View {
        MainCoordinatorView()
    }
}
