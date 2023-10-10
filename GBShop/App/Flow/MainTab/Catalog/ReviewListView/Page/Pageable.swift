//
//  Pageable.swift
//  GBShop
//
//  Created by Denis Dmitriev on 04.08.2023.
//

import Foundation

protocol Pageable {
    associatedtype Item: Identifiable, Hashable
    
    var metadata: Metadata { get set }
    var canLoadMorePages: Bool { get }
    var state: PagingState { get set }
    var threshold: Int { get }
    
    func onItemAppear(_ item: Item) async
}
