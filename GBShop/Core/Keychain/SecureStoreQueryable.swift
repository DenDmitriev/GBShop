//
//  SecureStoreQueryable.swift
//  GBShop
//
//  Created by Denis Dmitriev on 04.07.2023.
//

import Foundation

protocol SecureStoreQueryable {
  var query: [String: Any] { get }
}

struct GenericPasswordQueryable {
  let service: String
  let accessGroup: String?

  init(service: String, accessGroup: String? = nil) {
    self.service = service
    self.accessGroup = accessGroup
  }
}

extension GenericPasswordQueryable: SecureStoreQueryable {
  public var query: [String: Any] {
    var query: [String: Any] = [:]
    query[String(kSecClass)] = kSecClassGenericPassword
    query[String(kSecAttrService)] = service
    // Access group if target environment is not simulator
    #if !targetEnvironment(simulator)
    if let accessGroup = accessGroup {
      query[String(kSecAttrAccessGroup)] = accessGroup
    }
    #endif
    return query
  }
}

struct InternetPasswordQueryable {
  let server: String
  let port: Int
  let path: String
  let securityDomain: String
}

extension InternetPasswordQueryable: SecureStoreQueryable {
  public var query: [String: Any] {
    var query: [String: Any] = [:]
    query[String(kSecClass)] = kSecClassInternetPassword
    query[String(kSecAttrPort)] = port
    query[String(kSecAttrServer)] = server
    query[String(kSecAttrSecurityDomain)] = securityDomain
    query[String(kSecAttrPath)] = path
    return query
  }
}
