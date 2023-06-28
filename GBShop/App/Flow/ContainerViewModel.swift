//
//  ContainerViewModel.swift
//  GBShop
//
//  Created by Denis Dmitriev on 23.06.2023.
//

import Foundation

class ContainerViewModel: ObservableObject {
    
    let requestFactory = RequestFactory()
    
    init() {
        authRequest()
    }
    
    func authRequest() {
        let auth = requestFactory.makeAuthRequestFatory()
        
        var user = User(
            id: UUID(uuidString: "89675782-1A65-4002-B6F8-2D3FE6F0B297"),
            login: "Somebody",
            name: "Name",
            lastname: "Lastname",
            password: "mypassword",
            email: "some@some.ru",
            gender: "m",
            creditCard: "9872389-2424-234224-234",
            bio: "This is good! I think I will switch to another language")
        
        auth.registerUser(user: user) { response in
            switch response.result {
            case .success(let register):
                print(register)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }

        auth.login(login: "Somebody", password: "mypassword") { response in
            switch response.result {
            case .success(let login):
                print(login)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }

        user.email = "newMail@some.ru"

        auth.changeUserData(user: user) { response in
            switch response.result {
            case .success(let register):
                print(register)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }

        auth.logout(userId: user.id) { response in
            switch response.result {
            case .success(let logout):
                print(logout)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
