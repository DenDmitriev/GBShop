//
//  ProductRequestFactory.swift
//  GBShop
//
//  Created by Denis Dmitriev on 30.06.2023.
//

import Foundation
import Alamofire

protocol ProductRequestFactory {
    func categories(completionHandler: @escaping (AFDataResponse<[ProductCategory]>) -> Void)
    
    func products(by categoryID: UUID,
                  page: Int,
                  completionHandler: @escaping (AFDataResponse<ProductsByCategoryResult>) -> Void)
    
    func product(id: UUID,
                 completionHandler: @escaping (AFDataResponse<ProductResult>) -> Void)
}
