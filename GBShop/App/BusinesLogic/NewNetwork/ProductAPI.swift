//
//  ProductAPI.swift
//  GBShop
//
//  Created by Denis Dmitriev on 05.08.2023.
//

import Foundation

class ProductAPI: NetworkAPI {
    
    static func categories(router: ProductRequest.All) async -> Result<[ProductCategory], Error> {
        do {
            let data = try await NetworkManager.shared.get(
                path: router.path,
                parameters: router.parameters,
                method: router.method,
                headers: router.headers
            )
            let result: [ProductCategory] = try self.parseData(data: data)
            
            if !result.isEmpty {
                return .success(result)
            } else {
                let error: APIError = .empty
                return .failure(error)
            }
        } catch let error {
            return .failure(error)
        }
    }
    
    static func products(router: ProductRequest.ProductsByCategory) async -> Result<[Product], Error> {
        do {
            let data = try await NetworkManager.shared.get(
                path: router.path,
                parameters: router.parameters,
                method: router.method,
                headers: router.headers
            )
            let result: ProductsByCategoryResult = try self.parseData(data: data)
            
            if let products = result.products {
                return .success(products)
            } else {
                let error: APIError = .error(message: result.errorMessage)
                return .failure(error)
            }
        } catch let error {
            return .failure(error)
        }
        
    }
    
    static func product(router: ProductRequest.Product) async -> Result<Product, Error> {
        do {
            let data = try await NetworkManager.shared.get(
                path: router.path,
                parameters: router.parameters,
                method: router.method,
                headers: router.headers
            )
            let result: ProductResult = try self.parseData(data: data)
            
            if let product = result.product {
                return .success(product)
            } else {
                let error: APIError = .error(message: result.errorMessage)
                return .failure(error)
            }
        } catch let error {
            return .failure(error)
        }
    }
}
