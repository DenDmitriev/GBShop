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

    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: ContainerViewModel())
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
