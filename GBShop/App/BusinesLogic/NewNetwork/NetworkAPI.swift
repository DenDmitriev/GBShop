//
//  NetworkAPI.swift
//  GBShop
//
//  Created by Denis Dmitriev on 05.08.2023.
//

import Foundation
import Alamofire

class NetworkAPI {
    static func parseData<T: Decodable>(data: Data) throws -> T {
        guard let decodedData = try? JSONDecoder().decode(T.self, from: data)
        else {
            throw NSError(
                domain: "NetworkAPIError",
                code: 3,
                userInfo: [NSLocalizedDescriptionKey: "JSON decode error"]
            )
        }
        return decodedData
    }
}
