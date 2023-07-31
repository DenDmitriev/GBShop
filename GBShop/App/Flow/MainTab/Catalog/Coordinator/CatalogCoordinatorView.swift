//
//  CatalogCoordinatorView.swift
//  GBShop
//
//  Created by Denis Dmitriev on 26.07.2023.
//

import SwiftUI

struct CatalogCoordinatorView: View {
    
    @StateObject private var coordinator = CatalogCoordinator()
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            coordinator.build(page: .catalog)
                .navigationBarTitle("Catalog 🛒")
                .navigationDestination(for: CatalogPage.self) { page in
                    coordinator.build(page: page)
                }
                .sheet(item: $coordinator.sheet) { sheet in
                    coordinator.build(sheet: sheet)
                }
        }
        .environmentObject(coordinator)
    }
}

struct CatalogCoordinatorView_Previews: PreviewProvider {
    static var previews: some View {
        CatalogCoordinatorView()
    }
}
