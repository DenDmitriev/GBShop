//
//  ContentViewModel.swift
//  GBShop
//
//  Created by Denis Dmitriev on 23.06.2023.
//

import Foundation

class ContentViewModel: ObservableObject {
    
    let requestFactory = RequestFactory()
    
    init() {
        meRequest()
    }
    
    private func getToken() -> String? {
        let wrapper = KeychainWrapper()
        let userName = UserDefaultsHelper.userName
        do {
            if let token = try wrapper.getValue(for: userName) {
                return token
            } else {
                return nil
            }
        } catch let error {
            print(error)
        }
        
        return nil
    }
    
    func meRequest() {
        guard let token = getToken() else { return }
        let me = requestFactory.makeAuthRequestFatory()
        
        me.me(token: token) { response in
            switch response.result {
            case .success(let result):
                guard let me = result.user else { return }
                try? UserSession.shared.create(user: User(from: me), token: token)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
