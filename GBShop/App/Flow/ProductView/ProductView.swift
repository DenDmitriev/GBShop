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

    init(count: Binding<Int>, product: Product, viewModel: ProductViewModel) {
        self.viewModel = viewModel
        self.product = product
        self._count = count
    }

    var body: some View {
        ScrollView {
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
                
                Text(product.name)
                    .font(.title2)
                    .fontWeight(.medium)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                PriceView(price: product.price)

                Text(product.description)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                OrderButton(count: $count)
                
                LazyVGrid(columns: [GridItem(.flexible())]) {
                    Text("Отзывы")
                        .font(.title2)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top)
                    
                    Divider()
                    
                    ForEach(viewModel.reviews, id: \.id) { review in
                        ReviewView(review: review)
                            .padding(.bottom)
                    }
                }
            }
            .padding(.all, 16)
        }
    }
}

struct ProductView_Previews: PreviewProvider {
    static var previews: some View {
        ProductView(count: Binding<Int>.constant(.zero),
                    product: DummyData.product,
                    viewModel: ProductViewModel(product: DummyData.product,
                                                reviews: [DummyData.review1,
                                                          DummyData.review2,
                                                          DummyData.review3]))
    }
}
