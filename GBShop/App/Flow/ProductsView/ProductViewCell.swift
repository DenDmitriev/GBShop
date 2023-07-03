//
//  ProductViewCell.swift
//  GBShop
//
//  Created by Denis Dmitriev on 03.07.2023.
//

import SwiftUI

struct ProductViewCell: View {
    
    @State var product: Product
    
    var body: some View {
        NavigationLink {
            ProductView(product: product)
                .navigationBarTitleDisplayMode(.inline)
        } label: {
            VStack(spacing: 8) {
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
                    
                }
                Text(product.description)
                
            }
            .frame(maxHeight: 150)
        }
    }
}

struct ProductViewCell_Previews: PreviewProvider {
    static var previews: some View {
        ProductViewCell(product: Product(
            name: "Телевизор Витязь 24LH0201",
            price: 19990,
            description: "Лаконичный дизайн и современные технологии, обеспечивающие высокое качество изображения и звука, – вот основные особенности телевизора «Витязь» 43LF1204 Smart.")
        )
            .previewLayout(.fixed(width: 300, height: 150))
    }
}
