//
//  ReviewListView.swift
//  GBShop
//
//  Created by Denis Dmitriev on 03.08.2023.
//

import SwiftUI

struct ReviewListView: View {
    
    @ObservedObject var viewModel: ReviewListViewModel
    
    var body: some View {
        LazyVGrid(columns: [GridItem(.flexible())]) {
            ForEach(viewModel.reviews, id: \.id) { review in
                ReviewView(review: review)
                    .onAppear {
                        Task {
                            await viewModel.onItemAppear(review)
                        }
                    }
                    .padding(.bottom)
            }
        }
        .onAppear {
            Task {
                await viewModel.getReviews()
            }
        }
    }
}

struct ReviewListView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewListView(viewModel: ReviewListViewModel(product: DummyData.product))
    }
}
