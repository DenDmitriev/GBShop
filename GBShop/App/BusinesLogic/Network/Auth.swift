//
//  Auth.swift
//  GBShop
//
//  Created by Denis Dmitriev on 23.06.2023.
//

import Foundation
import Alamofire

class Auth: AbstractRequestFactory {
    let errorParser: AbstractErrorParser
    let sessionManager: Session
    let queue: DispatchQueue
//    let baseUrl = URL(string: "http://127.0.0.1:8080")!
    let baseUrl = URL(string: "https://gbshopbackend-denisdmitriev.amvera.io/")!
    
    init(errorParser: AbstractErrorParser,
         sessionManager: Session,
         queue: DispatchQueue = DispatchQueue.global(qos: .utility)) {
        self.errorParser = errorParser
        self.sessionManager = sessionManager
        self.queue = queue
    }
}

extension Auth: AuthRequestFactory {
    func login(login: String, password: String, completionHandler: @escaping (AFDataResponse<LoginResult>) -> Void) {
        let requestModel = Login(baseUrl: baseUrl, login: login, password: password)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func logout(userId: UUID, completionHandler: @escaping (AFDataResponse<LogoutResult>) -> Void) {
        let requestModel = LogoutUser(baseUrl: baseUrl, userId: userId)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func registerUser(user: User, completionHandler: @escaping (AFDataResponse<RegisterUserResult>) -> Void) {
        let requestModel = RegisterUser(baseUrl: baseUrl, user: user)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func changeUserData(user: User, completionHandler: @escaping (AFDataResponse<ChangeUserDataResult>) -> Void) {
        let requestModel = ChangeUserData(baseUrl: baseUrl, user: user)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

extension Auth {
    struct Login: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "/users/authorization"
        let login: String
        let password: String
        var parameters: Parameters? {
            return [
                "login": login,
                "password": password
            ]
        }
    }
    
    struct LogoutUser: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "/users/logout"
        let userId: UUID
        var parameters: Parameters? {
            return [
                "id": userId
            ]
        }
    }
    
    struct ChangeUserData: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "/users/update"
        let user: User
        var parameters: Parameters? {
            return [
                "id": user.id,
                "login": user.login,
                "name": user.name,
                "lastname": user.lastname,
                "password": user.password,
                "email": user.email,
                "gender": user.gender,
                "creditCard": user.creditCard,
                "bio": user.bio
            ]
        }
    }
    
    struct RegisterUser: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "/users/register"
        let user: User
        var parameters: Parameters? {
            return [
                "id": user.id,
                "login": user.login,
                "name": user.name,
                "lastname": user.lastname,
                "password": user.password,
                "email": user.email,
                "gender": user.gender,
                "creditCard": user.creditCard,
                "bio": user.bio
            ]
        }
    }
}
