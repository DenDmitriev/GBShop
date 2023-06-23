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
    
    func logout(userName: String,
                completionHandler: @escaping (AFDataResponse<LogoutResult>) -> Void)
}
