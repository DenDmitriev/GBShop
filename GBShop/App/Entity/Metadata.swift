//
//  Metadata.swift
//  GBShop
//
//  Created by Denis Dmitriev on 05.07.2023.
//

import Foundation

struct Metadata: Codable {
    let page: Int
    let per: Int
    let total: Int
    
    static let `default`: Metadata = Metadata(page: 1, per: 4, total: .zero)
}

extension Metadata: Equatable {}

extension Metadata {
    
    var nextPage: Int? {
        hasNextPage ? page + 1 : nil
    }
    
    var pages: Int {
        guard per != .zero else { return .zero }
        let fullPages = total / per
        let remainderPage = (total % per) > 0 ? 1 : 0
        return fullPages + remainderPage
    }
    
    var hasNextPage: Bool {
        pages != page
    }
}
