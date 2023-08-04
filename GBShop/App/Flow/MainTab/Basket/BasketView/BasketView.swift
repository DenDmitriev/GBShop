//
//  BasketView.swift
//  GBShop
//
//  Created by Denis Dmitriev on 03.07.2023.
//

import SwiftUI

struct BasketView: View {
    
    @ObservedObject private var viewModel: BasketViewModel
    @EnvironmentObject var orderService: OrderService
    
    init(viewModel: BasketViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                LazyVGrid(columns: [GridItem(.flexible())]) {
                    ForEach(orderService.order
                        .filter { $0.value != .zero }
                        .sorted(by: >),
                            id: \.key) { (product, _) in
                        BasketItemView(product: product)
                    }
                }
                .padding(.horizontal)
                
                if let card = viewModel.secureCard() {
                    HStack {
                        Text("Оплата картой")
                        Spacer()
                        Text(card)
                    }
                    .padding()
                } else {
                    Text("Добавьте карту оплаты")
                        .padding()
                }
                
                Text("Итого")
                    .foregroundColor(.secondary)
                    .fontWeight(.medium)
                
                Text(Formatter.shared.currency(by: orderService.total))
                    .font(.largeTitle)
                
                Button {
                    viewModel.payment(orderService: orderService)
                } label: {
                    HStack {
                        if !$orderService.isSynchronized.wrappedValue {
                            ProgressView()
                        }
                        
                        Text("Оплатить")
                            .font(.headline)
                            .padding()
                        
                    }
                }
                .buttonStyle(.borderedProminent)
                .disabled(viewModel.basketIsEmpty(orderService: orderService)
                    || !$orderService.isSynchronized.wrappedValue)
            }
        }
    }
}

struct BasketView_Previews: PreviewProvider {
    static var previews: some View {
        BasketView(viewModel: BasketViewModel(coordinator: BasketCoordinator()))
            .environmentObject(OrderService())
    }
}
