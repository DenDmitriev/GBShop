//
//  ReceiptView.swift
//  GBShop
//
//  Created by Denis Dmitriev on 26.07.2023.
//

import SwiftUI

struct ReceiptView: View {
    
    @EnvironmentObject var coordinator: BasketCoordinator
    @ObservedObject var viewModel = ReceiptViewModel()
    var receipt: Receipt
    
    private let columns = [GridItem(.flexible())]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 8) {
                
                Text(Date.now, format: .dateTime)
                    .font(.caption)
                    .padding(.vertical)
                
                ForEach(Array(receipt.items.enumerated()), id: \.element.name) { index, receipt in
                    VStack {
                        HStack(spacing: 8) {
                            Text((index + 1).formatted(.number))
                            Text(receipt.name)
                            Text("x" + receipt.count.formatted(.number))
                            Line()
                                .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                                .foregroundColor(.gray)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .frame(height: 1)
                            Text(Formatter.shared.currency(by: receipt.price))
                        }
                        .padding(.horizontal)
                    }
                }
                
                Divider()
                
                HStack {
                    Text("Итого")
                    Text(Formatter.shared.currency(by: receipt.total))
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                .font(.title2)
                .padding(.horizontal)
            }
        }
        .navigationBarTitle("Чек 🧾", displayMode: .automatic)
        .toolbar {
            ToolbarItem {
                Button {
                    coordinator.dismissSheet()
                } label: {
                    Image(systemName: "xmark")
                        .padding(.all)
                }
            }
        }
    }
}

struct Line: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        return path
    }
}

struct ReceiptView_Previews: PreviewProvider {
    static var previews: some View {
        ReceiptView(receipt: Receipt(items: DummyData.receiptItems, total: 283.0))
    }
}
