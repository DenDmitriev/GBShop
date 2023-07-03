//
//  ProductView.swift
//  GBShop
//
//  Created by Denis Dmitriev on 03.07.2023.
//

import SwiftUI

struct ProductView: View {
    
    @ObservedObject private var viewModel: ProductViewModel
    var product: Product
    
    init(product: Product) {
        self.viewModel = ProductViewModel()
        self.product = product
    }
    
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                Text(product.name)
                    .font(.title2)
                Spacer()
            }
            HStack {
                Text(product.price.formatted(.number))
                    .font(.largeTitle)
                Spacer()
            }
            
            HStack {
                Button {
                    viewModel.order(id: product.id)
                } label: {
                    Text("Order")
                }
                .buttonStyle(.borderedProminent)
                .font(.headline)
                
                Spacer()
            }
            
            Divider()
            
            HStack {
                Text(product.description)
                Spacer()
            }
            Spacer()
            
        }
        .padding(.horizontal, 16)
    }
}

struct ProductView_Previews: PreviewProvider {
    static var previews: some View {
        ProductView(product: Product(
            name: "Телевизор Витязь 24LH0201",
            price: 19990,
            description: "Лаконичный дизайн и современные технологии, обеспечивающие высокое качество изображения и звука, – вот основные особенности телевизора «Витязь» 43LF1204 Smart.")
        )
    }
}
