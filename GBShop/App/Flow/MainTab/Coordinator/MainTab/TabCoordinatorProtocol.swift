//
//  TabCoordinatorProtocol.swift
//  GBShop
//
//  Created by Denis Dmitriev on 01.08.2023.
//

import SwiftUI

protocol TabCoordinatorProtocol: AnyObject {
    var tab: MainTab { get set }
    func change(_ tab: MainTab)
}

extension TabCoordinatorProtocol {
    func change(_ tab: MainTab) {
        self.tab = tab
    }
}
