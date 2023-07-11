//
//  ProductView.swift
//  GBShop
//
//  Created by Denis Dmitriev on 03.07.2023.
//

import SwiftUI

struct ProductView: View {

    @ObservedObject private var viewModel: ProductViewModel
    @Binding var count: Int
    
    var product: Product

    init(count: Binding<Int>, product: Product) {
        self.viewModel = ProductViewModel()
        self.product = product
        self._count = count
    }

    var body: some View {
        VStack(spacing: 8) {
            ZStack(alignment: .bottomLeading) {
                if let url = URL(string: product.image) {
                    AsyncImage(url: url)
                        .aspectRatio(contentMode: .fit)
                }
                
                if product.price.discount != .zero {
                    StickersView(stickers: [.discount(percent: product.price.discount)])
                        .padding([.leading, .bottom])
                }
            }
            
            HStack {
                Text(product.name)
                    .font(.title2)
                Spacer()
            }
            
            PriceView(price: product.price)

            HStack {
                Text(product.description)
                Spacer()
            }
            
            OrderButton(count: $count)
            
            Spacer()
        }
        .padding(.all, 16)
    }
}

struct ProductView_Previews: PreviewProvider {
    static var previews: some View {
        ProductView(count: Binding<Int>.constant(.zero),
                    product: Product(
                        name: "Молоко Самокат",
                        price: Price(price: 80, discount: 9),
                        description: "Пастеризованное, 3,2% 950 мл",
                        image: "https://cm.samokat.ru/processed/l/original/158334_425819778.jpg"))
    }
}
