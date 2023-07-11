//
//  PriceView.swift
//  GBShop
//
//  Created by Denis Dmitriev on 08.07.2023.
//

import SwiftUI

struct PriceView: View {
    
    @State var isDiscounted: Bool
    @State var showDiscount: Bool
    
    let price: Price
    
    init(price: Price, showDiscount: Bool? = nil) {
        self.price = price
        self.isDiscounted = price.discount == .zero ? false : true
        self.showDiscount = showDiscount ?? true
    }
    
    var body: some View {
        VStack {
            
            HStack {
                if price.discount != .zero {
                    Text(CurrencyFormatter.shared.formatter(by: price.discountPrice))
                        .foregroundColor(.red)
                }
                
                if price.discount != .zero {
                    Text(CurrencyFormatter.shared.formatter(by: price.price))
                        .foregroundColor(.gray)
                        .strikethrough()
                } else {
                    Text(CurrencyFormatter.shared.formatter(by: price.price))
                        .foregroundColor(.primary)
                }
                
                Spacer()
            }
        }
        .font(.headline)
    }
}

struct PriceView_Previews: PreviewProvider {
    static var previews: some View {
        PriceView(price: Price(price: 100, discount: 25))
            .previewLayout(.fixed(width: 150, height: 60))
    }
}
