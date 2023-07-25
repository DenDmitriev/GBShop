//
//  MainTabView.swift
//  GBShop
//
//  Created by Denis Dmitriev on 03.07.2023.
//

import SwiftUI

enum MainTab {
    case catalog
    case basket
    case account
}

struct MainTabView: View {

    @State var tab: MainTab = .catalog
    @ObservedObject private var viewModel: MainViewModel

    init() {
        self.viewModel = MainViewModel()
    }

    var body: some View {
        TabView(selection: $tab) {
            NavigationStack {
                CatalogView()
                    .navigationBarTitle("Catalog 🛒")
            }
            .tag(MainTab.catalog)
            .tabItem {
                Label("Catalog", systemImage: "house")
            }

            NavigationStack {
                BasketView()
                    .navigationBarTitle("Basket 🛍️")
            }
            .tag(MainTab.basket)
            .tabItem {
                Label("Basket", systemImage: "basket")
            }

            NavigationStack {
                UserView()
                    .navigationBarTitle("Me 👤")
            }
            .tag(MainTab.account)
            .tabItem {
                Label("User", systemImage: "person")
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
