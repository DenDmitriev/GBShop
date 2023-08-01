//
//  ErrorParserStub.swift
//  GBShopTests
//
//  Created by Denis Dmitriev on 28.06.2023.
//

import Foundation
@testable import GBShop

struct ErrorParserStub: AbstractErrorParser {

    func parse(_ result: Error) -> Error {
        return ApiErrorStub.fatalError
    }

    func parse(response: HTTPURLResponse?, data: Data?, error: Error?) -> Error? {
        return error
    }
}
