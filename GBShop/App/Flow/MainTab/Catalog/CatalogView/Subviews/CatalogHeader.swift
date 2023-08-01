//
//  CatalogHeader.swift
//  GBShop
//
//  Created by Denis Dmitriev on 10.07.2023.
//

import SwiftUI

struct CatalogHeader: View {
    
    @EnvironmentObject var coordinator: CatalogCoordinator
    @Binding var scrollingCategory: Int
    var categories: [ProductCategory]
    
    let name: String
    
    var body: some View {
        HStack {
            Text(name)
                .font(.title2)
            .fontWeight(.semibold)
            
            Button {
                coordinator
                    .present(sheet: .catalogLinks(names: categories.map { $0.name },
                                                  selected: $scrollingCategory))
            } label: {
                Image(systemName: "chevron.down")
                    .foregroundColor(.gray)
                    .font(.headline)
            }
        }
        .padding(8.0)
        .background(.background)
        .cornerRadius(8)
    }
}

struct CatalogHeader_Previews: PreviewProvider {
    static var previews: some View {
        CatalogHeader(scrollingCategory: Binding<Int>.constant(.zero),
                      categories: [],
                      name: "")
    }
}
