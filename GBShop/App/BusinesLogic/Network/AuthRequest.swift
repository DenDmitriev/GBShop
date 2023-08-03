//
//  Auth.swift
//  GBShop
//
//  Created by Denis Dmitriev on 23.06.2023.
//

import Foundation
import Alamofire

class AuthRequest: AbstractRequestFactory {
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

extension AuthRequest: AuthRequestFactory {
    func me(token: String, completionHandler: @escaping (AFDataResponse<MeResult>) -> Void) {
        let requestModel = LoginUserWithToken(baseUrl: baseUrl, encoding: .bearer(token: token))
        self.request(request: requestModel, completionHandler: completionHandler)
    }

    func login(email: String, password: String, completionHandler: @escaping (AFDataResponse<LoginResult>) -> Void) {
        let requestModel = LoginUser(baseUrl: baseUrl,
                                 email: email,
                                 password: password,
                                 encoding: .basicAuth(username: email, password: password))
        self.request(request: requestModel, completionHandler: completionHandler)
    }

    func logout(userId: UUID, completionHandler: @escaping (AFDataResponse<LogoutResult>) -> Void) {
        let requestModel = LogoutUser(baseUrl: baseUrl, userId: userId)
        self.request(request: requestModel, completionHandler: completionHandler)
    }

    func registerUser(create: User.Create, completionHandler: @escaping (AFDataResponse<RegisterUserResult>) -> Void) {
        let requestModel = RegisterUser(baseUrl: baseUrl, create: create)
        self.request(request: requestModel, completionHandler: completionHandler)
    }

    func changeUserData(update: User.Update,
                        completionHandler: @escaping (AFDataResponse<ChangeUserDataResult>) -> Void) {
        let requestModel = ChangeUserData(baseUrl: baseUrl, update: update)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

extension AuthRequest {
    struct LoginUserWithToken: RequestRouter {
        var baseUrl: URL
        var method: HTTPMethod = .get
        var path: String = "/me"
        var parameters: Parameters?
        var encoding: RequestRouterEncoding
    }

    struct LoginUser: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "/login"
        let email: String
        let password: String
        var encoding: RequestRouterEncoding
        var parameters: Parameters?
    }

    struct LogoutUser: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "/logout"
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
        let update: User.Update
        var parameters: Parameters? {
            return [
                "id": update.id,
                "name": update.name,
                "email": update.email,
                "creditCard": update.creditCard
            ]
        }
    }

    struct RegisterUser: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "/users/register"
        let create: User.Create
        var parameters: Parameters? {
            return [
                "name": create.name,
                "password": create.password,
                "confirmPassword": create.confirmPassword,
                "email": create.email,
                "creditCard": create.creditCard
            ]
        }
    }
}
