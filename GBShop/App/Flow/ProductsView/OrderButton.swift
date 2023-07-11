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
        VStack {
            if count <= .zero {
                HStack {
                    Spacer()
                    
                    Button {
                        $count.wrappedValue += 1
                    } label: {
                        Spacer()
                        
                        Text("В корзину")
                        
                        Spacer()
                    }
                }
            } else {
                HStack {
                    Button {
                        $count.wrappedValue -= 1
                    } label: {
                        Image(systemName: "minus")
                    }
                    
                    Spacer()
                    
                    Text(count.formatted(.number))
                    
                    Spacer()
                    
                    Button {
                        $count.wrappedValue += 1
                    } label: {
                        Image(systemName: "plus")
                    }
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
