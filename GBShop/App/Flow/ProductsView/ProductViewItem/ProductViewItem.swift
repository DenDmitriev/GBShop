//
//  ProductViewCell.swift
//  GBShop
//
//  Created by Denis Dmitriev on 03.07.2023.
//

import SwiftUI

struct ProductViewItem: View {
    
    @State var product: Product
    @ObservedObject var viewModel: ProductViewItemModel
    @StateObject var orderService: OrderService = UserSession.shared.orderService
    @State private var isShowingDetail = false
    
    init(product: Product, count: Int) {
        self._product = State(initialValue: product)
        self.viewModel = ProductViewItemModel()
    }
    
    var body: some View {
        VStack {
            Button {
                self.isShowingDetail.toggle()
            } label: {
                VStack(spacing: 8) {
                    ZStack(alignment: .bottomLeading) {
                        if let url = URL(string: product.image) {
                            ZStack {
                                AsyncImage(url: url)
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
            .sheet(isPresented: $isShowingDetail) {
                ProductView(count: Binding<Int>(
                    get: {
                        orderService.order[product] ?? .zero
                    },
                    set: {
                        orderService.order[product] = $0
                    }), product: product, viewModel: ProductViewModel(product: product))
            }
            
            Spacer()
            
            OrderButton(count: Binding<Int>(
                get: {
                    orderService.order[product] ?? .zero
                },
                set: {
                    orderService.order[product] = $0
                }))
        }
        .environmentObject(orderService)
    }
}

struct ProductViewCell_Previews: PreviewProvider {
    static var previews: some View {
        ProductViewItem(product: DummyData.product,
                        count: .zero)
        .previewLayout(.fixed(width: 150, height: 400))
    }
}
