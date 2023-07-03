//
//  GBShopApp.swift
//  GBShop
//
//  Created by Denis Dmitriev on 22.06.2023.
//

import SwiftUI

@main
struct GBShopApp: App {
    
    let persistenceController = PersistenceController.shared
    
    @ObservedObject var userSession = UserSession.shared

    var body: some Scene {
        WindowGroup {
            /*
            ContentView(viewModel: ContentViewModel())
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
             */
            
            switch userSession.isAuth {
            case true:
                MainTabView()
            case false:
                AuthView()
            }
        }
    }
}
