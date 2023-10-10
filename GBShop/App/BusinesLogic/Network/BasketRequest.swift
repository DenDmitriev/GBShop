//
//  BasketRequest.swift
//  GBShop
//
//  Created by Denis Dmitriev on 25.07.2023.
//

import Foundation
import Alamofire

class BasketRequest: AbstractRequestFactory {
    var errorParser: AbstractErrorParser
    var sessionManager: Session
    var queue: DispatchQueue
//    let baseUrl = URL(string: "http://127.0.0.1:8080")!
    let baseUrl = URL(string: "https://gbshopbe-denisdmitriev.amvera.io")!
    
    init(errorParser: AbstractErrorParser,
         sessionManager: Session,
         queue: DispatchQueue = DispatchQueue.global(qos: .utility)) {
        self.errorParser = errorParser
        self.sessionManager = sessionManager
        self.queue = queue
    }
}

extension BasketRequest: BasketRequestFactory {
    
    func getBasket(user userID: UserID, completionHandler: @escaping (AFDataResponse<Basket.Result>) -> Void) {
        let token = UserSession.shared.token
        let requestModel = Get(baseUrl: baseUrl, headers: [.authorization(bearerToken: token)], userID: userID)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func addToBasket(of userID: UserID,
                     for productID: ProductID,
                     on count: Int,
                     completionHandler: @escaping (AFDataResponse<Basket.Update>) -> Void) {
        let token = UserSession.shared.token
        let requestModel = Add(
            baseUrl: baseUrl,
            headers: [.authorization(bearerToken: token)],
            userID: userID,
            productID: productID,
            count: count
        )
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func deleteFromBasket(user userID: UserID,
                          for productID: ProductID,
                          on count: Int,
                          completionHandler: @escaping (AFDataResponse<Basket.Update>) -> Void) {
        let token = UserSession.shared.token
        let requestModel = Delete(
            baseUrl: baseUrl,
            headers: [.authorization(bearerToken: token)],
            userID: userID,
            productID: productID,
            count: count
        )
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func payment(user userID: UserID,
                 total: Double,
                 completionHandler: @escaping (AFDataResponse<Basket.PaymentResult>) -> Void) {
        let token = UserSession.shared.token
        let requestModel = Payment(
            baseUrl: baseUrl,
            headers: [.authorization(bearerToken: token)],
            userID: userID,
            total: total
        )
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

extension BasketRequest {
    struct Get: RequestRouter {
        var baseUrl: URL
        var headers: HTTPHeaders?
        var method: HTTPMethod = .get
        var path: String = "/baskets/get"
        let userID: UUID
        var parameters: Parameters? {
            return [
                "userID": userID
            ]
        }
    }
    
    struct Add: RequestRouter {
        var baseUrl: URL
        var headers: HTTPHeaders?
        var method: HTTPMethod = .post
        var path: String = "/baskets/add"
        let userID: UUID
        let productID: UUID
        let count: Int
        var parameters: Parameters? {
            return [
                "userID": userID,
                "productID": productID,
                "count": count
            ]
        }
    }
    
    struct Delete: RequestRouter {
        var baseUrl: URL
        var headers: HTTPHeaders?
        var method: HTTPMethod = .post
        var path: String = "/baskets/delete"
        let userID: UUID
        let productID: UUID
        let count: Int
        var parameters: Parameters? {
            return [
                "userID": userID,
                "productID": productID,
                "count": count
            ]
        }
    }
    
    struct Payment: RequestRouter {
        var baseUrl: URL
        var headers: HTTPHeaders?
        var method: HTTPMethod = .post
        var path: String = "/baskets/payment"
        let userID: UUID
        let total: Double
        var parameters: Parameters? {
            return [
                "userID": userID,
                "total": total
            ]
        }
    }
}
