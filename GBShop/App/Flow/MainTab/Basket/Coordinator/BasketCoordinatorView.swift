//
//  BasketCoordinatorView.swift
//  GBShop
//
//  Created by Denis Dmitriev on 31.07.2023.
//

import SwiftUI

struct BasketCoordinatorView: View {
    
    @StateObject private var coordinator = BasketCoordinator()
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            coordinator.build(page: .basket)
                .navigationBarTitle("Basket 🛍️")
                .navigationDestination(for: BasketPage.self) { page in
                    coordinator.build(page: page)
                }
                .sheet(item: $coordinator.sheet) { sheet in
                    coordinator.build(sheet: sheet)
                }
        }
        .environmentObject(coordinator)
    }
}

struct BasketCoordinatorView_Previews: PreviewProvider {
    static var previews: some View {
        BasketCoordinatorView()
    }
}
