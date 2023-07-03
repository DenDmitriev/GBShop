//
//  AuthRequestFactory.swift
//  GBShop
//
//  Created by Denis Dmitriev on 23.06.2023.
//

import Foundation
import Alamofire

protocol AuthRequestFactory {
    func login(email: String,
               password: String,
               completionHandler: @escaping (AFDataResponse<LoginResult>) -> Void)
    
    func logout(userId: UUID,
                completionHandler: @escaping (AFDataResponse<LogoutResult>) -> Void)
    
    func registerUser(create: User.Create,
                      completionHandler: @escaping (AFDataResponse<RegisterUserResult>) -> Void)
    
    func changeUserData(update: User.Update,
                        completionHandler: @escaping (AFDataResponse<ChangeUserDataResult>) -> Void)
}
