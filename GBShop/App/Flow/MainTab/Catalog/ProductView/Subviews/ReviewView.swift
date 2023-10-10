//
//  ReviewView.swift
//  GBShop
//
//  Created by Denis Dmitriev on 19.07.2023.
//

import SwiftUI

struct ReviewView: View {
    
    @State var review: Review
    
    var body: some View {
        VStack(spacing: 8) {
            Text(review.reviewer)
                .font(.title3)
                .fontWeight(.medium)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack {
                ForEach(1...5, id: \.self) { value in
                    Image(systemName: value <= review.rating ? "star.fill" : "star")
                }
                .foregroundColor(.yellow)
                
                Text(Formatter.shared.date(by: review.createdAt))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Text(review.review)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct ReviewView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewView(review: DummyData.review1)
    }
}
