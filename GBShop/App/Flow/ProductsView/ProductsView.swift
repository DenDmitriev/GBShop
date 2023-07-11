//
//  ProductsView.swift
//  GBShop
//
//  Created by Denis Dmitriev on 03.07.2023.
//

import SwiftUI

struct ProductsView: View {
    
    @ObservedObject private var viewModel: ProductsViewModel
    
    let columns = [
            GridItem(.flexible()),
            GridItem(.flexible())
        ]

    init(category: ProductCategory) {
        self.viewModel = ProductsViewModel(category: category)
    }

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(viewModel.products, id: \.id) {
                    ProductViewItem(product: $0, count: .zero)
                        .padding(4)
                }
            }
            .padding(8)
        }
    }
}

struct ProductsView_Previews: PreviewProvider {
    static var previews: some View {
        ProductsView(category: ProductCategory(id: UUID(uuidString: "96123E21-8912-435A-A200-A3BB413296E4"),
                                               name: "Category",
                                               description: "Description"))
    }
}
