//
//  AuthAPI.swift
//  GBShop
//
//  Created by Denis Dmitriev on 05.08.2023.
//

import Foundation

class AuthAPI: NetworkAPI {
    
    static func login(router: AuthRequest.LoginUser) async -> Result<User.Login, Error> {
        do {
            let data = try await NetworkManager.shared.get(
                path: router.path,
                parameters: router.parameters,
                method: router.method,
                headers: router.headers
            )
            let result: LoginResult = try self.parseData(data: data)
            
            if let user = result.user {
                return .success(user)
            } else {
                let error: APIError = .error(message: result.errorMessage)
                return .failure(error)
            }
        } catch let error {
            return .failure(error)
        }
    }
    
    static func me(router: AuthRequest.LoginUserWithToken) async -> Result<User.Public, Error> {
        do {
            let data = try await NetworkManager.shared.get(
                path: router.path,
                parameters: router.parameters,
                method: router.method,
                headers: router.headers
            )
            let result: MeResult = try self.parseData(data: data)
            
            if let user = result.user {
                return .success(user)
            } else {
                let error: APIError = .error(message: result.errorMessage)
                return .failure(error)
            }
        } catch let error {
            return .failure(error)
        }
    }
    
    static func logout(router: AuthRequest.LogoutUser) async -> Result<LogoutResult, Error> {
        do {
            let data = try await NetworkManager.shared.get(
                path: router.path,
                parameters: router.parameters,
                method: router.method,
                headers: router.headers
            )
            let result: LogoutResult = try self.parseData(data: data)
            
            if result.result == 1 {
                return .success(result)
            } else {
                let error: APIError = .error(message: result.errorMessage)
                return .failure(error)
            }
        } catch let error {
            return .failure(error)
        }
    }
    
    static func registerUser(router: AuthRequest.RegisterUser) async -> Result<RegisterUserResult, Error> {
        do {
            let data = try await NetworkManager.shared.get(
                path: router.path,
                parameters: router.parameters,
                method: router.method,
                headers: router.headers
            )
            let result: RegisterUserResult = try self.parseData(data: data)
            
            if result.result == 1 {
                return .success(result)
            } else {
                let error: APIError = .error(message: result.errorMessage)
                return .failure(error)
            }
        } catch let error {
            return .failure(error)
        }
    }
    
    static func changeUserData(router: AuthRequest.ChangeUserData) async -> Result<User, Error> {
        do {
            let data = try await NetworkManager.shared.get(
                path: router.path,
                parameters: router.parameters,
                method: router.method,
                headers: router.headers
            )
            let result: ChangeUserDataResult = try self.parseData(data: data)
            
            if let user = result.user {
                return .success(user)
            } else {
                let error: APIError = .error(message: result.errorMessage)
                return .failure(error)
            }
        } catch let error {
            return .failure(error)
        }
    }
}
