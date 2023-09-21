//
//  CategoryView.swift
//  GBShop
//
//  Created by Denis Dmitriev on 03.07.2023.
//

import SwiftUI

struct CategoryView: View {
    
    @EnvironmentObject var coordinator: CatalogCoordinator
    @EnvironmentObject var orderService: OrderService
    @ObservedObject private var viewModel: CategoryViewModel
    
    let columns = [
            GridItem(.flexible()),
            GridItem(.flexible())
        ]

    init(viewModel: CategoryViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(viewModel.products, id: \.id) {
                    ProductViewItem(product: $0)
                        .padding(4)
                }
            }
            .padding(8)
        }
        .onAppear {
            Task {
                await viewModel.getProducts()
            }
        }
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView(
            viewModel: CategoryViewModel(
                category: ProductCategory(
                    id: UUID(uuidString: "96123E21-8912-435A-A200-A3BB413296E4"),
                    name: "Category",
                    description: "Description"
                )
            )
        )
    }
}
