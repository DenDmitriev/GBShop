//
//  BasketCoordinator.swift
//  GBShop
//
//  Created by Denis Dmitriev on 31.07.2023.
//

import SwiftUI

class BasketCoordinator: ObservableObject {
    
    @Published var path = NavigationPath()
    
    @Published var sheet: BasketSheet?
    @Published var page: BasketPage?
    
    @Published var orderService = {
        UserSession.shared.orderService ?? OrderService()
    }()
    
    func push(_ page: BasketPage) {
        path.append(page)
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
    
    func present(sheet: BasketSheet) {
        self.sheet = sheet
    }
    
    func dismissSheet() {
        self.sheet = nil
    }

    @ViewBuilder
    func build(page: BasketPage) -> some View {
        switch page {
        case .basket:
            BasketView(viewModel: BasketViewModel(coordinator: self))
                .environmentObject(orderService)
        }
    }
    
    @ViewBuilder
    func build(sheet: BasketSheet) -> some View {
        switch sheet {
        case .receipt(let receipt):
            NavigationStack {
                ReceiptView(receipt: receipt)
            }
        }
    }
}
