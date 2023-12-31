//
//  CatalogLinksView.swift
//  GBShop
//
//  Created by Denis Dmitriev on 09.07.2023.
//

import SwiftUI

struct CatalogLinksView: View {
    
    @EnvironmentObject var coordinator: CatalogCoordinator
    @Binding var scrollingCategory: Int
    
    let categories: [String]
    
    var body: some View {
        LazyVStack(spacing: 8) {
            ForEach(Array(zip(categories.indices, categories)), id: \.0) { index, category in
                HStack {
                    Button {
                        scrollingCategory = index
                        coordinator.dismissSheet()
                    } label: {
                        Text(category)
                            .font(.title2)
                            .fontWeight(.semibold)
                    }
                    .accessibilityIdentifier("category")
                    .foregroundColor(.primary)
                    
                    Spacer()
                }
            }
        }
        .padding(.all)
    }
}

struct CatalogLinksView_Previews: PreviewProvider {
    static var previews: some View {
        CatalogLinksView(scrollingCategory: Binding<Int>.constant(.zero),
                         categories: ["Хлеб и выпечка",
                                      "Овощи и фрукты",
                                      "Мясо и рыба"])
    }
}
