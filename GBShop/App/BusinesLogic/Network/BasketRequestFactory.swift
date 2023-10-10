//
//  BasketRequestFactory.swift
//  GBShop
//
//  Created by Denis Dmitriev on 25.07.2023.
//

import Foundation
import Alamofire

protocol BasketRequestFactory {
    typealias UserID = UUID
    typealias ProductID = UUID
    
    func getBasket(user userID: UserID,
                   completionHandler: @escaping (AFDataResponse<Basket.Result>) -> Void)
    
    func addToBasket(of userID: UserID,
                     for productID: ProductID,
                     on count: Int,
                     completionHandler: @escaping (AFDataResponse<Basket.Update>) -> Void)
    
    func deleteFromBasket(user userID: UserID,
                          for productID: ProductID,
                          on count: Int,
                          completionHandler: @escaping (AFDataResponse<Basket.Update>) -> Void)
    
    func payment(user userID: UserID,
                 total: Double,
                 completionHandler: @escaping (AFDataResponse<Basket.PaymentResult>) -> Void)
}
