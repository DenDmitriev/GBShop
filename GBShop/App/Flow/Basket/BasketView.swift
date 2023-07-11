//
//  BasketView.swift
//  GBShop
//
//  Created by Denis Dmitriev on 03.07.2023.
//

import SwiftUI

struct BasketView: View {
    
    @ObservedObject private var viewModel: BasketViewModel
    @StateObject var orderService = UserSession.shared.orderService
    
    init() {
        self.viewModel = BasketViewModel()
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
                
                Text(CurrencyFormatter.shared.formatter(by: orderService.total))
                    .font(.largeTitle)
                
                Button {
                    print("процесс оплаты")
                } label: {
                    Text("Оплатить")
                        .font(.headline)
                        .padding()
                }
                .buttonStyle(.borderedProminent)
                
            }
        }
        .environmentObject(orderService)
    }
}

struct BasketView_Previews: PreviewProvider {
    static var previews: some View {
        BasketView()
    }
}
