//
//  CatalogView.swift
//  GBShop
//
//  Created by Denis Dmitriev on 03.07.2023.
//

import SwiftUI

struct CatalogView: View {
    
    @ObservedObject private var viewModel: CatalogViewModel
    @State private var isShowingCategory: Bool = false
    
    let columns = [
        GridItem(.flexible())
    ]
    
    init() {
        self.viewModel = CatalogViewModel()
    }
    
    var body: some View {
        ScrollView {
            ScrollViewReader { proxy in
                LazyVGrid(columns: columns,
                          spacing: .zero,
                          pinnedViews: [.sectionHeaders]) {
                    ForEach(Array(zip(viewModel.category.indices, viewModel.category)), id: \.0) { index, category in
                        Section {
                            ProductsView(category: category)
                                .padding(.bottom, 16)
                            
                        } header: {
                            HStack {
                                CatalogHeader(isShowingCategory: $isShowingCategory,
                                              scrollingCategory: $viewModel.scrollingCategory,
                                              categories: viewModel.category,
                                              name: category.name)
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
    }
}

struct CatalogView_Previews: PreviewProvider {
    static var previews: some View {
        CatalogView()
    }
}
