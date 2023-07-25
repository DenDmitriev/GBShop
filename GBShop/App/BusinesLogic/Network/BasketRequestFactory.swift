//
//  BasketRequestFactory.swift
//  GBShop
//
//  Created by Denis Dmitriev on 25.07.2023.
//

import Foundation
import Alamofire

protocol BasketRequestFactory {
    
    func getBasket(of userID: UUID,
                   completionHandler: @escaping (AFDataResponse<Basket.Result>) -> Void)
    
    func addToBasket(of userID: UUID,
                    for productID: UUID,
                    on count: Int,
                    completionHandler: @escaping (AFDataResponse<Basket.Update>) -> Void)
    
    func deleteFromBasket(of userID: UUID,
                    for productID: UUID,
                    on count: Int,
                    completionHandler: @escaping (AFDataResponse<Basket.Update>) -> Void)
}
