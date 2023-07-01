//
//  AuthRequestFactory.swift
//  GBShop
//
//  Created by Denis Dmitriev on 23.06.2023.
//

import Foundation
import Alamofire

protocol AuthRequestFactory {
    func login(login: String,
               password: String,
               completionHandler: @escaping (AFDataResponse<LoginResult>) -> Void)
    
    func logout(userId: UUID,
                completionHandler: @escaping (AFDataResponse<LogoutResult>) -> Void)
    
    func registerUser(user: User,
                      completionHandler: @escaping (AFDataResponse<RegisterUserResult>) -> Void)
    
    func changeUserData(user: User,
                        completionHandler: @escaping (AFDataResponse<ChangeUserDataResult>) -> Void)
}
