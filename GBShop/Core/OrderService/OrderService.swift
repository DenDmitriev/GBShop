//
//  OrderService.swift
//  GBShop
//
//  Created by Denis Dmitriev on 10.07.2023.
//

import Foundation
import SwiftUI
import Firebase

final class OrderService: ObservableObject {
    
    @Published var order: [Product: Int] = [:]
    @Published var isSynchronized: Bool = false
    @Published var receipt: Receipt?
    
    var userID: UUID? = {
        UserSession.shared.user?.id ?? nil
    }()
    private let requestFactory = RequestFactory()
    private let maxCount: Int = 20
    
    var total: Double {
        return order.reduce(0.0) { partialResult, item in
            partialResult + item.key.price.discountPrice * Double(item.value)
        }
    }
    
    // MARK: - Init
    
    init(userID: UUID? = nil) {
        self.userID = userID
    }
    
    // MARK: - Functions
    
    func count(for product: Product) -> Binding<Int> {
        return Binding<Int>(
            get: { [weak self] in
                self?.order[product] ?? .zero
            },
            set: { [weak self] in
                self?.update(product: product, count: $0)
            })
    }
    
    func update(product: Product, count: Int) {
        guard let oldCount = order[product]
        else {
            order[product] = count
            addProductRequest(productID: product.id, count: count)
            return
        }
        
        switch count {
        case maxCount:
            return
        case oldCount:
            return
        case ...0:
            order.removeValue(forKey: product)
            removeProductRequest(productID: product.id, count: count)
        case 1..<oldCount:
            order[product] = count
            removeProductRequest(productID: product.id, count: count)
        case (oldCount + 1)..<maxCount:
            order[product] = count
            addProductRequest(productID: product.id, count: count)
        default:
            return
        }
    }
    
    func getBasketRequest() {
        guard let userID = userID else { return }
        isSynchronized(false)
        let basketRequest = requestFactory.makeBasketRequestFactory()
        basketRequest.getBasket(user: userID) { response in
            switch response.result {
            case .success(let basketResult):
                if basketResult.result == .zero {
                    print(basketResult.errorMessage ?? "")
                    self.isSynchronized(true)
                } else {
                    guard let basket = basketResult.basket else { return }
                    self.loadOrder(basket: basket)
                }
                Crashlytics.crashlytics().log("Basket fetch")
            case .failure(let error):
                print(error.localizedDescription)
                Crashlytics.crashlytics().record(error: error)
            }
        }
    }
    
    func payment(completion: @escaping (Receipt?) -> Void) {
        guard let userID = userID else { return }
        isSynchronized(false)
        let basketRequest = requestFactory.makeBasketRequestFactory()
        basketRequest.payment(user: userID, total: total) { response in
            switch response.result {
            case .success(let paymentResult):
                if paymentResult.result == .zero {
                    print(paymentResult.errorMessage ?? "")
                } else {
                    guard
                        let items = paymentResult.receipt,
                            let total = paymentResult.total
                    else { return }
                    self.closeOrder(items: items,
                                    total: total,
                                    completion: completion)
                }
                Crashlytics.crashlytics().log("Payment success")
            case .failure(let error):
                print(error.localizedDescription)
                Crashlytics.crashlytics().record(error: error)
            }
        }
    }
    
    // MARK: - Private functions
    
    // MARK: Requests
    
    private func addProductRequest(productID: UUID, count: Int) {
        guard let userID = userID else { return }
        isSynchronized(false)
        let basketRequest = requestFactory.makeBasketRequestFactory()
        basketRequest.addToBasket(of: userID, for: productID, on: count) { response in
            switch response.result {
            case .success(let basketUpdate):
                if basketUpdate.result == .zero {
                    print(basketUpdate.errorMessage ?? "")
                } else {
                    print(basketUpdate.userMessage ?? "")
                    self.isSynchronized(true)
                }
                Crashlytics.crashlytics().log("Add product to order")
            case .failure(let error):
                print(error.localizedDescription)
                Crashlytics.crashlytics().record(error: error)
            }
        }
    }
    
    private func removeProductRequest(productID: UUID, count: Int) {
        guard let userID = userID else { return }
        isSynchronized(false)
        let basketRequest = requestFactory.makeBasketRequestFactory()
        basketRequest.deleteFromBasket(user: userID, for: productID, on: count) { response in
            switch response.result {
            case .success(let basketUpdate):
                if basketUpdate.result == .zero {
                    print(basketUpdate.errorMessage ?? "")
                } else {
                    print(basketUpdate.userMessage ?? "")
                    self.isSynchronized(true)
                }
                Crashlytics.crashlytics().log("Remove product from order")
            case .failure(let error):
                print(error.localizedDescription)
                Crashlytics.crashlytics().record(error: error)
            }
        }
    }
    
    // MARK: Work with order
    
    private func loadOrder(basket: Basket) {
        DispatchQueue.main.async {
            self.order = self.orderAdapter(for: basket)
            self.isSynchronized(true)
        }
    }
    
    private func closeOrder(items: [ReceiptItem], total: Double, completion: @escaping (Receipt?) -> Void) {
        let mainQueue = DispatchQueue.main
        let group = DispatchGroup()
        let workItem = DispatchWorkItem(block: {
            self.order.removeAll()
            self.isSynchronized = true
            self.receipt = Receipt(items: items, total: total)
        })
        mainQueue.async(group: group, execute: workItem)
        group.notify(queue: DispatchQueue.main) {
            completion(self.receipt)
        }
    }
    
    private func orderAdapter(for basket: Basket) -> [Product: Int] {
        let originalProducts = Array(Set(basket.products))
        var order = [Product: Int]()
        originalProducts.forEach { product in
            order[product] = basket.products
                .filter({ $0.id == product.id })
                .count
        }
        return order
    }
    
    private func isSynchronized(_ set: Bool) {
        DispatchQueue.main.async {
            self.isSynchronized = set
        }
    }
}
