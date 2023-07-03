//
//  ContentViewModel.swift
//  GBShop
//
//  Created by Denis Dmitriev on 23.06.2023.
//

import Foundation

class ContentViewModel: ObservableObject {
    
    let requestFactory = RequestFactory()
    
    init() {
        authRequest()
//        productRequest()
    }
    
    func productRequest() {
        let productRequest = requestFactory.makeProductRequestFatory()
        
        productRequest.categories { response in
            switch response.result {
            case .success(let categories):
                print(categories)
                categories.forEach { category in
                    productRequest.products(by: category.id, page: .zero) { response in
                        switch response.result {
                        case .success(let products):
                            print(products)
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
//        productRequest.product(id: UUID(uuidString: "2DE48542-FBD2-44D4-9A16-1A10D99887C4")!) { response in
//            switch response.result {
//            case .success(let productResult):
//                print(productResult.product)
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
    }
    
    func authRequest() {
        let auth = requestFactory.makeAuthRequestFatory()
        
        var create = User.Create(
            name: "Name",
            email: "some@some.ru",
            password: "secret42",
            confirmPassword: "secret42",
            creditCard: "1234123412341234")
        
        auth.registerUser(create: create) { response in
            switch response.result {
            case .success(let register):
                print(register)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }

//        auth.login(email: "Somebody", password: "mypassword") { response in
//            switch response.result {
//            case .success(let login):
//                print(login)
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//
//        user.email = "newMail@some.ru"
//
//        auth.changeUserData(user: user) { response in
//            switch response.result {
//            case .success(let register):
//                print(register)
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//
//        auth.logout(userId: user.id) { response in
//            switch response.result {
//            case .success(let logout):
//                print(logout)
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
    }
}
