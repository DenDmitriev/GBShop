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
    
    func getBasket(of userID: UserID,
                   completionHandler: @escaping (AFDataResponse<Basket.Result>) -> Void)
    
    func addToBasket(of userID: UserID,
                     for productID: ProductID,
                     on count: Int,
                     completionHandler: @escaping (AFDataResponse<Basket.Update>) -> Void)
    
    func deleteFromBasket(of userID: UserID,
                          for productID: ProductID,
                          on count: Int,
                          completionHandler: @escaping (AFDataResponse<Basket.Update>) -> Void)
    
    func payment(of userID: UserID,
                 completionHandler: @escaping (AFDataResponse<Basket.PaymentResult>) -> Void)
}
