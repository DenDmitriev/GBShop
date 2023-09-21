//
//  ProductRequest.swift
//  GBShop
//
//  Created by Denis Dmitriev on 30.06.2023.
//

import Foundation
import Alamofire

class ProductRequest: AbstractRequestFactory {
    let errorParser: AbstractErrorParser
    let sessionManager: Session
    let queue: DispatchQueue
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

extension ProductRequest: ProductRequestFactory {
    func categories(completionHandler: @escaping (AFDataResponse<[ProductCategory]>) -> Void) {
        let token = UserSession.shared.token
        let requestModel = All(baseUrl: baseUrl, headers: [.authorization(bearerToken: token)])
        self.request(request: requestModel, completionHandler: completionHandler)
    }

    func products(by categoryID: UUID,
                  page: Int,
                  per: Int,
                  completionHandler: @escaping (AFDataResponse<ProductsByCategoryResult>) -> Void) {
        let token = UserSession.shared.token
        let requestModel = ProductsByCategory(baseUrl: baseUrl, headers: [.authorization(bearerToken: token)], page: page, per: per, categoryID: categoryID)
        self.request(request: requestModel, completionHandler: completionHandler)
    }

    func product(id: UUID, completionHandler: @escaping (AFDataResponse<ProductResult>) -> Void) {
        let token = UserSession.shared.token
        let requestModel = Product(baseUrl: baseUrl, headers: [.authorization(bearerToken: token)], id: id)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

extension ProductRequest {
    struct All: RequestRouter {
        var baseUrl: URL
        var headers: HTTPHeaders?
        var method: HTTPMethod = .get
        var path: String = "/categories/all"
        var parameters: Parameters? {
            [:]
        }
    }

    struct ProductsByCategory: RequestRouter {
        var baseUrl: URL
        var headers: HTTPHeaders?
        var method: HTTPMethod = .get
        var path: String = "/products/category"
        let page: Int
        let per: Int
        let categoryID: UUID
        var parameters: Parameters? {
            return [
                "page": page,
                "per": per,
                "category": categoryID
            ]
        }
    }

    struct Product: RequestRouter {
        var baseUrl: URL
        var headers: HTTPHeaders?
        var method: HTTPMethod = .get
        let id: UUID
        var path: String
        var parameters: Parameters? {
            [:]
        }

        init(baseUrl: URL, headers: HTTPHeaders?, id: UUID) {
            self.baseUrl = baseUrl
            self.id = id
            self.path = "/products/\(id.uuidString)"
        }
    }
}
