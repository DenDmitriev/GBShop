//
//  UserDefaultsHelper.swift
//  GBShop
//
//  Created by Denis Dmitriev on 04.07.2023.
//

import Foundation

private enum UserDefaultsKeys: String {
    case userName = "userName"
    
    var asString: String {
        return self.rawValue
    }
}

struct UserDefaultsHelper {
    static var userName: String {
        get {
            UserDefaults.standard
                .object(forKey: UserDefaultsKeys.userName.asString) as? String ?? ""
        }
        set {
            UserDefaults.standard
                .set(newValue, forKey: UserDefaultsKeys.userName.asString)
        }
    }
}
