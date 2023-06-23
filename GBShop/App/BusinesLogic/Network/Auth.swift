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
    let baseUrl = URL(string: "https://raw.githubusercontent.com/GeekBrainsTutorial/online-store-api/master/responses/")!
    
    init(errorParser: AbstractErrorParser,
         sessionManager: Session,
         queue: DispatchQueue = DispatchQueue.global(qos: .utility)) {
        self.errorParser = errorParser
        self.sessionManager = sessionManager
        self.queue = queue
    }
}

extension Auth: AuthRequestFactory {
    func login(userName: String, password: String, completionHandler: @escaping (AFDataResponse<LoginResult>) -> Void) {
        let requestModel = Login(baseUrl: baseUrl, login: userName, password: password)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func logout(userId: Int, completionHandler: @escaping (AFDataResponse<LogoutResult>) -> Void) {
        let requestModel = Logout(baseUrl: baseUrl, userId: userId)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func registerUser(userId: Int, login: String, password: String, email: String, gender: String, creditCard: String, bio: String, completionHandler: @escaping (AFDataResponse<RegisterUserResult>) -> Void) {
        let requestModel = RegisterUser(baseUrl: baseUrl, login: userName, password: password)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
    
    func changeUserData(userId: Int, login: String, password: String, email: String, gender: String, creditCard: String, bio: String, completionHandler: @escaping (AFDataResponse<RegisterUserResult>) -> Void) {
        let requestModel = ChangeUserData(baseUrl: baseUrl, userId: Int, login: String, password: String, email: String, gender: String, creditCard: String, bio: String)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

extension Auth {
    struct Login: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "login.json"
        let login: String
        let password: String
        var parameters: Parameters? {
            return [
                "username": login,
                "password": password
            ]
        }
    }
    
    struct LogoutUser: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "logout.json"
        let userId: Int
        var parameters: Parameters? {
            return [
                "userId": login
            ]
    }
    
    struct RegisterUser: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "register.json"
        let userId: Int
        let login: String
        let password: String
        let email: String
        let gender: String
        let creditCard: String
        let bio: String
        var parameters: Parameters? {
            return [
                "userId": userId
                "username": login,
                "password": password,
                "email": email,
                "gender": gender,
                "creditCard": creditCard,
                "bio": bio
            ]
        }
    }
    
    struct ChangeUserData: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "register.json"
        let userId: Int
        let login: String
        let password: String
        let email: String
        let gender: String
        let creditCard: String
        let bio: String
        var parameters: Parameters? {
            return [
                "userId": userId
                "username": login,
                "password": password,
                "email": email,
                "gender": gender,
                "creditCard": creditCard,
                "bio": bio
            ]
        }
    }
}
