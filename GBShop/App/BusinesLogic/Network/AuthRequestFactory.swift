//
//  AuthRequestFactory.swift
//  GBShop
//
//  Created by Denis Dmitriev on 23.06.2023.
//

import Foundation
import Alamofire

protocol AuthRequestFactory {
    func login(userName: String,
               password: String,
               completionHandler: @escaping (AFDataResponse<LoginResult>) -> Void)
    
    func logout(userId: Int,
                completionHandler: @escaping (AFDataResponse<LogoutResult>) -> Void)
    
    func registerUser(userId: Int,
                      login: String,
                      password: String,
                      email: String,
                      gender: String,
                      creditCard: String,
                      bio: String,
                      completionHandler: @escaping (AFDataResponse<RegisterUserResult>) -> Void)
    
    func changeUserData(userId: Int,
                        login: String,
                        password: String,
                        email: String,
                        gender: String,
                        creditCard: String,
                        bio: String,
                        completionHandler: @escaping (AFDataResponse<ChangeUserDataResult>) -> Void)
}
