//
//  NetworkManager.swift
//  GBShop
//
//  Created by Denis Dmitriev on 05.08.2023.
//

import Foundation
import Alamofire

actor NetworkManager: GlobalActor {
    
    static let shared = NetworkManager()
    
    private let apiBaseURL = "https://gbshopbe-denisdmitriev.amvera.io"
    private let maxWaitTime = 15.0
    
    private init() {}
    
    func get(path: String, parameters: Parameters?, method: HTTPMethod, headers: HTTPHeaders? = nil) async throws -> Data {
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(
                apiBaseURL + path,
                method: method,
                parameters: parameters,
                headers: headers,
                requestModifier: { $0.timeoutInterval = self.maxWaitTime }
            )
            .responseData { response in
                switch(response.result) {
                case let .success(data):
                    continuation.resume(returning: data)
                case let .failure(error):
                    continuation.resume(throwing: self.handleError(error: error))
                }
            }
        }
    }
    
    private func handleError(error: AFError) -> Error {
        if let underlyingError = error.underlyingError {
            let nsError = underlyingError as NSError
            let code = nsError.code
            if code == NSURLErrorNotConnectedToInternet ||
                code == NSURLErrorTimedOut ||
                code == NSURLErrorInternationalRoamingOff ||
                code == NSURLErrorDataNotAllowed ||
                code == NSURLErrorCannotFindHost ||
                code == NSURLErrorCannotConnectToHost ||
                code == NSURLErrorNetworkConnectionLost {
                var userInfo = nsError.userInfo
                userInfo[NSLocalizedDescriptionKey] = "Unable to connect to the server"
                let currentError = NSError(
                    domain: nsError.domain,
                    code: code,
                    userInfo: userInfo
                )
                return currentError
            }
        }
        return error
    }
}
