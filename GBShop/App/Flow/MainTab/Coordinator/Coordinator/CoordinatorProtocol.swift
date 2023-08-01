//
//  CoordinatorProtocol.swift
//  GBShop
//
//  Created by Denis Dmitriev on 01.08.2023.
//

import SwiftUI

protocol CoordinatorProtocol: AnyObject {
    associatedtype Page: Hashable
    associatedtype Sheet: Hashable
    associatedtype FullScreenCover: Hashable
    
    var parent: TabCoordinatorProtocol? { get set }
    
    var path: NavigationPath { get set }
    var sheet: Sheet? { get set }
    var page: Page? { get set }
    var fullScreenCover: FullScreenCover? { get set }
    
    func push(_ page: Page)
    func pop()
    func popToRoot()

    func present(sheet: Sheet)
    func dismissSheet()

    func present(fullScreenCover: FullScreenCover)
    func dismissCover()
}

extension CoordinatorProtocol {
    func push(_ page: Page) {
        path.append(page)
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
    
    func present(sheet: Sheet) {
        self.sheet = sheet
    }
    
    func dismissSheet() {
        self.sheet = nil
    }
    
    func present(fullScreenCover: FullScreenCover) {
        self.fullScreenCover = fullScreenCover
    }
    
    func dismissCover() {
        fullScreenCover = nil
    }
}
