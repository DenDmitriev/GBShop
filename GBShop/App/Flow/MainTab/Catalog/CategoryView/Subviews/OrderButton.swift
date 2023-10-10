//
//  OrderButton.swift
//  GBShop
//
//  Created by Denis Dmitriev on 07.07.2023.
//

import SwiftUI

struct OrderButton: View {
    
    @Binding var count: Int
    
    var body: some View {
        Group {
            switch count {
            case .zero:
                Button {
                    count += 1
                } label: {
                    Text("В корзину")
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                .accessibilityIdentifier("order")
            default:
                HStack {
                    Button {
                        count -= 1
                    } label: {
                        Image(systemName: "minus")
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                    .accessibilityIdentifier("popOrder")
                    
                    Text(count.formatted(.number))
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    Button {
                        count += 1
                    } label: {
                        Image(systemName: "plus")
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                    .accessibilityIdentifier("pushOrder")
                }
            }
        }
        .font(.headline)
        .foregroundColor(.primary)
        .padding(8)
        .background(Color(uiColor: .systemGray5))
        .cornerRadius(8)
    }
}

struct OrderButton_Previews: PreviewProvider {
    static var previews: some View {
        OrderButton(count: Binding<Int>.constant(1))
            .previewLayout(.fixed(width: 150, height: 75))
    }
}
