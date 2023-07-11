//
//  CatalogHeader.swift
//  GBShop
//
//  Created by Denis Dmitriev on 10.07.2023.
//

import SwiftUI

struct CatalogHeader: View {
    
    @Binding var isShowingCategory: Bool
    @Binding var scrollingCategory: Int
    var categories: [ProductCategory]
    
    let name: String
    
    var body: some View {
        HStack {
            Text(name)
                .font(.title2)
            .fontWeight(.semibold)
            
            Button {
                isShowingCategory.toggle()
            } label: {
                Image(systemName: "chevron.down")
                    .foregroundColor(.gray)
                    .font(.headline)
            }
            .sheet(isPresented: $isShowingCategory) {
                CatalogLinksView(scrollingCategory: $scrollingCategory, categories: categories.map { $0.name })
                    .presentationDetents([.medium])
                    .presentationDragIndicator(.visible)
            }
        }
        .padding(8.0)
        .background(.background)
        .cornerRadius(8)
    }
}

struct CatalogHeader_Previews: PreviewProvider {
    static var previews: some View {
        CatalogHeader(isShowingCategory: Binding<Bool>.constant(false),
                      scrollingCategory: Binding<Int>.constant(.zero),
                      categories: [],
                      name: "")
    }
}
