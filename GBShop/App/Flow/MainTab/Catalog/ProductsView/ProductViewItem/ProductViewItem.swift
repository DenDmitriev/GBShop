//
//  ProductViewItem.swift
//  GBShop
//
//  Created by Denis Dmitriev on 03.07.2023.
//

import SwiftUI

struct ProductViewItem: View {
    
    @State var product: Product
    @EnvironmentObject var coordinator: CatalogCoordinator
    @EnvironmentObject var orderService: OrderService
    
    init(product: Product) {
        self._product = State(initialValue: product)
    }
    
    var body: some View {
        VStack {
            Button {
                coordinator.present(sheet: .product(product: product))
            } label: {
                VStack(spacing: 8) {
                    ZStack(alignment: .bottomLeading) {
                        if let url = URL(string: product.image) {
                            ZStack {
                                AsyncImage(url: url, image: { image in
                                    Image(uiImage: image)
                                        .resizable()
                                })
                                .aspectRatio(contentMode: .fit)
                                .cornerRadius(8)
                            }
                        }
                        
                        if product.price.discount != .zero {
                            StickersView(stickers: [.discount(percent: product.price.discount)])
                                .padding([.leading, .bottom])
                        }
                    }
                    
                    VStack(spacing: 8) {
                        HStack {
                            Text(product.name)
                                .multilineTextAlignment(.leading)
                                .foregroundColor(.primary)
                                .font(.title3)
                                .fontWeight(.medium)
                            Spacer()
                        }
                        
                        PriceView(price: product.price)
                    }
                    
                    HStack {
                        Text(product.description)
                            .multilineTextAlignment(.leading)
                            .foregroundColor(.primary)
                        Spacer()
                    }
                }
            }
            
            Spacer()
            
            OrderButton(count: orderService.count(for: product))
        }
    }
}

struct ProductViewCell_Previews: PreviewProvider {
    static var previews: some View {
        ProductViewItem(product: DummyData.product)
            .environmentObject(OrderService())
            .previewLayout(.fixed(width: 150, height: 400))
    }
}
