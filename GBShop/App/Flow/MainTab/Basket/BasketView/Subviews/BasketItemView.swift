//
//  BasketItemView.swift
//  GBShop
//
//  Created by Denis Dmitriev on 08.07.2023.
//

import SwiftUI

struct BasketItemView: View {
    
    @EnvironmentObject var orderService: OrderService
    var product: Product
    
    var body: some View {
        HStack(spacing: 16) {
            if let url = URL(string: product.image) {
                AsyncImage(url: url, image: { image in
                    Image(uiImage: image)
                        .resizable()
                })
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: UIScreen.main.bounds.width / 5)
                    .cornerRadius(8)
            }
            
            VStack {
                HStack {
                    Text(product.name)
                    Spacer()
                }
                PriceView(price: product.price, showDiscount: false)
            }
            
            OrderButton(count: orderService.count(for: product))
                .frame(maxWidth: UIScreen.main.bounds.width / 4)
        }
    }
}

struct BasketItemView_Previews: PreviewProvider {
    static var previews: some View {
        BasketItemView(product: Product(id: UUID(),
                                        name: "Молоко Самокат",
                                        price: Price(price: 80,
                                                     discount: 9),
                                        description: "Пастеризованное, 3,2% 950 мл",
                                        image: "https://cm.samokat.ru/processed/l/original/158334_425819778.jpg"))
        .previewLayout(.fixed(width: 400, height: 120))
    }
}
