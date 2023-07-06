//
//  ProductsView.swift
//  GBShop
//
//  Created by Denis Dmitriev on 03.07.2023.
//

import SwiftUI

struct ProductsView: View {
    @ObservedObject private var viewModel: ProductsViewModel

    init(category: ProductCategory) {
        self.viewModel = ProductsViewModel(category: category)
    }

    var body: some View {
        NavigationView {
            List(viewModel.products) { product in
                ProductViewCell(product: product)
            }
            .listStyle(.inset)
        }
    }
}

struct ProductsView_Previews: PreviewProvider {
    static var previews: some View {
        ProductsView(category: ProductCategory(name: "Category", description: "Description"))
    }
}
