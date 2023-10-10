//
//  PagingState.swift
//  GBShop
//
//  Created by Denis Dmitriev on 04.08.2023.
//

import Foundation

enum PagingState: Equatable, RawRepresentable {
    typealias RawValue = Int
    
    case loadingFirstPage
    case loaded
    case loadingNextPage
    case error(error: Error)
    
    var rawValue: Int {
        switch self {
        case .loadingFirstPage:
            return 0
        case .loaded:
            return 1
        case .loadingNextPage:
            return 2
        case .error:
            return 3
        }
    }
    
    init?(rawValue: Int) {
        nil
    }
    
    static func == (lhs: PagingState, rhs: PagingState) -> Bool {
        lhs.rawValue == rhs.rawValue
    }
}
