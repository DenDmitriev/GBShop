//
//  ReviewListView.swift
//  GBShop
//
//  Created by Denis Dmitriev on 03.08.2023.
//

import SwiftUI

struct ReviewListView: View {
    
    @Binding var reviews: [Review]
    
    var body: some View {
        LazyVGrid(columns: [GridItem(.flexible())]) {
            ForEach(reviews, id: \.id) { review in
                ReviewView(review: review)
                    .padding(.bottom)
            }
        }
    }
}

struct ReviewListView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewListView(reviews: Binding<[Review]>.constant([DummyData.review1,
                                                            DummyData.review2,
                                                            DummyData.review3]))
    }
}
