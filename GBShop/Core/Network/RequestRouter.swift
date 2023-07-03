//
//  RequestRouter.swift
//  GBShop
//
//  Created by Denis Dmitriev on 23.06.2023.
//

import Foundation
import Alamofire

enum RequestRouterEncoding {
    case url, json, auth(username: String, password: String)
}

protocol RequestRouter: URLRequestConvertible {
    var baseUrl: URL { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: Parameters? { get }
    var fullUrl: URL { get }
    var encoding: RequestRouterEncoding { get }
}

extension RequestRouter {
    var fullUrl: URL {
        return baseUrl.appendingPathComponent(path)
    }
    
    var encoding: RequestRouterEncoding {
        return .url
    }
    
    func asURLRequest() throws -> URLRequest {
        var urlRequest = URLRequest(url: fullUrl)
        urlRequest.httpMethod = method.rawValue
        switch self.encoding {
        case .url:
            return try URLEncoding.default.encode(urlRequest, with: parameters)
        case .json:
            return try JSONEncoding.default.encode(urlRequest, with: parameters)
        case .auth(username: let username, password: let password):
            let authData = (username + ":" + password).data(using: .utf8)!.base64EncodedString()
            urlRequest.addValue("Basic \(authData)", forHTTPHeaderField: "Authorization")
            return try URLEncoding.default.encode(urlRequest, with: parameters)
        }
    }
}
