//
//  CatalogView.swift
//  GBShop
//
//  Created by Denis Dmitriev on 03.07.2023.
//

import SwiftUI

struct CatalogView: View {
    @ObservedObject private var viewModel: CatalogViewModel

    init() {
        self.viewModel = CatalogViewModel()
    }

    var body: some View {
        List(viewModel.category) { category in
            NavigationLink {
                ProductsView(category: category)
                    .navigationBarTitle(category.name ?? "")
            } label: {
                Text(category.name ?? "N/A")
            }

        }
        .listStyle(.inset)

    }
}

struct CatalogView_Previews: PreviewProvider {
    static var previews: some View {
        CatalogView()
    }
}
