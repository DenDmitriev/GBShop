//
//  AbstractErrorParser.swift
//  GBShop
//
//  Created by Denis Dmitriev on 23.06.2023.
//

import Foundation

protocol AbstractErrorParser {
    func parse(_ result: Error) -> Error
    func parse(response: HTTPURLResponse?, data: Data?, error: Error?) -> Error?
}
