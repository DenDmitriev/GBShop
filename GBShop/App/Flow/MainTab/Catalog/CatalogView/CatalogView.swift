//
//  CatalogView.swift
//  GBShop
//
//  Created by Denis Dmitriev on 03.07.2023.
//

import SwiftUI

struct CatalogView: View {
    
    @ObservedObject private var viewModel: CatalogViewModel
    @EnvironmentObject var coordinator: CatalogCoordinator
    @EnvironmentObject var orderService: OrderService
    @State private var isShowingCategory: Bool = false
    
    let columns = [
        GridItem(.flexible())
    ]
    
    init(viewModel: CatalogViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ScrollView {
            ScrollViewReader { proxy in
                LazyVGrid(columns: columns,
                          spacing: .zero,
                          pinnedViews: [.sectionHeaders]) {
                    ForEach(Array(zip(viewModel.category.indices,
                                      viewModel.categoryViewModels)),
                            id: \.0) { index, categoryViewModel in
                        Section {
                            CategoryView(viewModel: categoryViewModel)
                                .padding(.bottom, 16)
                            
                        } header: {
                            HStack {
                                CatalogHeader(scrollingCategory: $viewModel.scrollingCategory,
                                              categories: viewModel.category,
                                              name: categoryViewModel.category.name)
                                .id(index)
                                
                                Spacer()
                                
                            }
                            .padding(.horizontal, 8)
                        }
                    }
                    .onReceive(viewModel.$scrollingCategory) { index in
                        withAnimation(.easeInOut(duration: 0.3)) {
                            proxy.scrollTo(index, anchor: .top)
                        }
                    }
                }
            }
        }
        .overlay {
            if !orderService.order.isEmpty {
                ToBasketButton()
                    .padding()
                    .frame(maxWidth: .infinity)
                    .frame(maxHeight: .infinity, alignment: .bottom)
            }
        }
    }
}

struct CatalogView_Previews: PreviewProvider {
    static var previews: some View {
        CatalogView(viewModel: CatalogViewModel())
            .environmentObject(OrderService())
    }
}
