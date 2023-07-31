//
//  CatalogCoordinator.swift
//  GBShop
//
//  Created by Denis Dmitriev on 26.07.2023.
//

import SwiftUI

class CatalogCoordinator: ObservableObject {
    
    typealias Page = CatalogPage
    typealias Sheet = CatalogSheet
    typealias FullScreenCover = CatalogCover
    
    @Published var path = NavigationPath()
    
    @Published var sheet: CatalogSheet?
    @Published var page: CatalogPage?
    @Published var fullScreenCover: CatalogCover?
    
    @Published var catalogViewModel = CatalogViewModel()
    
    @Published var orderService = {
        UserSession.shared.orderService ?? OrderService()
    }()
    
    func push(_ page: CatalogPage) {
        path.append(page)
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
    
    func present(sheet: CatalogSheet) {
        self.sheet = sheet
    }
    
    func dismissSheet() {
        self.sheet = nil
    }
    
    func present(fullScreenCover: CatalogCover) {}
    
    func dismissCover() {}
    
    @ViewBuilder
    func build(page: CatalogPage) -> some View {
        switch page {
        case .catalog:
            CatalogView(viewModel: catalogViewModel)
                .environmentObject(orderService)
        }
    }
    
    @ViewBuilder
    func build(sheet: CatalogSheet) -> some View {
        switch sheet {
        case .product(let product):
            ProductView(viewModel: ProductViewModel(product: product))
                .environmentObject(orderService)
        case .catalogLinks(let names, let selected):
            CatalogLinksView(scrollingCategory: selected, categories: names)
                .presentationDetents([.medium])
                .presentationDragIndicator(.visible)
        }
    }
    
    @ViewBuilder
    func build(cover: CatalogCover) -> some View {
        switch cover {
        case .empty:
            EmptyView()
        }
    }
}
