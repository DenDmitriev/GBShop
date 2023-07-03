//
//  MainTabView.swift
//  GBShop
//
//  Created by Denis Dmitriev on 03.07.2023.
//

import SwiftUI

struct MainTabView: View {
    
    @ObservedObject private var viewModel: MainViewModel
    
    init() {
        self.viewModel = MainViewModel()
    }
    
    var body: some View {
        TabView {
            NavigationStack {
                CatalogView()
                    .navigationBarTitle("Catalog 🛒")
            }
            .tabItem {
                Label("Catalog", systemImage: "house")
            }
            
            NavigationStack {
                BasketView()
                    .navigationBarTitle("Basket 🛍️")
            }
            .tabItem {
                Label("Basket", systemImage: "basket")
            }
            
            NavigationStack {
                UserView()
                    .navigationBarTitle("Me 👤")
            }
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
