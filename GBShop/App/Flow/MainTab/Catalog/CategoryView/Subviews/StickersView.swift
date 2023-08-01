//
//  StickersView.swift
//  GBShop
//
//  Created by Denis Dmitriev on 09.07.2023.
//

import SwiftUI

struct StickersView: View {
    
    let stickers: [Sticker]
    
    private let degrees: Double = -6
    private let corner: CGFloat = 8
    private let spacing: CGFloat = 4
    
    var body: some View {
        VStack(alignment: .leading, spacing: spacing) {
            ForEach(stickers, id: \.self) { kind in
                switch kind {
                case .discount(let percent):
                    Text("–" + percentFormatter(percent))
                        .font(.caption)
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .padding(4)
                        .background(.red)
                        .cornerRadius(corner)
                        .rotationEffect(.degrees(degrees))
                case .new:
                    Text("Новинка")
                        .font(.caption)
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .padding(4)
                        .background(.yellow)
                        .cornerRadius(corner)
                        .rotationEffect(.degrees(degrees))
                case .custom(text: let text, color: let color):
                    Text(text)
                        .font(.caption)
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .padding(4)
                        .background(Color(uiColor: color))
                        .cornerRadius(corner)
                        .rotationEffect(.degrees(degrees))
                }
            }
        }
    }
}

private func percentFormatter(_ number: Int) -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .percent
    let part = Double(number) / 100
    let string = formatter.string(for: part)
    return string ?? ""
}

struct StickerView_Previews: PreviewProvider {
    static var previews: some View {
        StickersView(stickers: [.discount(percent: 15),
                                .new,
                                .custom(text: "Custom", color: .systemGreen)]
        )
    }
}
