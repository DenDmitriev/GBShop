//
//  ProductView.swift
//  GBShop
//
//  Created by Denis Dmitriev on 03.07.2023.
//

import SwiftUI

struct ProductView: View {
    
    @EnvironmentObject var coordinator: CatalogCoordinator
    @EnvironmentObject var orderService: OrderService
    @ObservedObject private var viewModel: ProductViewModel
    
    init(viewModel: ProductViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 8) {
                ZStack(alignment: .bottomLeading) {
                    if let url = URL(string: viewModel.product.image) {
                        AsyncImage(url: url, image: { image in
                            Image(uiImage: image)
                                .resizable()
                        })
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(8)
                    }
                    
                    if viewModel.product.price.discount != .zero {
                        StickersView(stickers: [.discount(percent: viewModel.product.price.discount)])
                            .padding([.leading, .bottom])
                    }
                }
                
                Text(viewModel.product.name)
                    .font(.title2)
                    .fontWeight(.medium)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                PriceView(price: viewModel.product.price)
                
                Text(viewModel.product.description)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                OrderButton(count: orderService.count(for: viewModel.product))
                
                HStack {
                    Text("Отзывы")
                        .font(.title)
                    
                    Button {
                        coordinator.present(sheet: .reviewCreator(product: viewModel.product))
                    } label: {
                        Image(systemName: "plus.circle")
                            .font(.title2)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top)
                
                ReviewListView(reviews: $viewModel.reviews)
            }
            .padding(.all, 16)
        }
    }
}

struct ProductView_Previews: PreviewProvider {
    static var previews: some View {
        ProductView(viewModel: ProductViewModel(product: DummyData.product,
                                                reviews: [DummyData.review1,
                                                          DummyData.review2,
                                                          DummyData.review3]))
        .environmentObject(OrderService())
        .environmentObject(CatalogCoordinator())
    }
}
