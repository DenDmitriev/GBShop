//
//  ToBasketButton.swift
//  GBShop
//
//  Created by Denis Dmitriev on 01.08.2023.
//

import SwiftUI

struct ToBasketButton: View {
    
    @EnvironmentObject var coordinator: CatalogCoordinator
    @EnvironmentObject var orderService: OrderService
    
    var body: some View {
        Button {
            coordinator.parent?.change(.basket)
        } label: {
            HStack {
                Text("К корзине")
                Text("•")
                Text(orderService.order.count.formatted(.number))
                Spacer()
                Text(CurrencyFormatter.shared.formatter(by: orderService.total))
                    .fontWeight(.bold)
            }
            .padding(.vertical, 8)
        }
        .buttonStyle(.borderedProminent)
    }
}

struct ToBasketButton_Previews: PreviewProvider {
    static var previews: some View {
        ToBasketButton()
            .environmentObject(CatalogCoordinator())
            .environmentObject(OrderService())
    }
}
