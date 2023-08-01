//
//  MainTabCoordinator.swift
//  GBShop
//
//  Created by Denis Dmitriev on 26.07.2023.
//

import Foundation
import SwiftUI

class MainTabCoordinator: ObservableObject, TabCoordinatorProtocol {
    typealias Tab = MainTab
    
    @Published var tab: MainTab = .catalog
    
    func change(_ tab: MainTab) {
        self.tab = tab
    }
    
    @ViewBuilder
    func build(tab: MainTab) -> some View {
        switch tab {
        case .catalog:
            CatalogCoordinatorView(coordinator: CatalogCoordinator(parent: self))
                .tag(tab)
                .tabItem {
                    Label("Catalog", systemImage: "house")
                }
        case .basket:
            BasketCoordinatorView()
                .tag(tab)
                .tabItem {
                    Label("Basket", systemImage: "basket")
                }
        case .user:
            UserCoordinatorView()
                .tag(tab)
                .tabItem {
                    Label("User", systemImage: "person")
                }
        }
    }
}
