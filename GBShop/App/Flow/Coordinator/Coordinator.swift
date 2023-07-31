//
//  Coordinator.swift
//  GBShop
//
//  Created by Denis Dmitriev on 26.07.2023.
//

import SwiftUI

protocol CoordinatorProtocol {
    associatedtype Body : View
    associatedtype Page
    associatedtype Sheet
    associatedtype FullScreenCover
    
    var path: NavigationPath { get set }
    var sheet: Self.Sheet? { get set }
    var page: Self.Page? { get set }
    var fullScreenCover: Self.FullScreenCover? { get set }
    
    func push(_ page: Page)
    func pop()
    func popToRoo()

    func present(sheet: Sheet)
    func dismissSheet()

    func present(fullScreenCover: FullScreenCover)
    func dismissCover()
    
    @ViewBuilder @MainActor func build(page: Self.Page) -> Self.Body
    @ViewBuilder @MainActor func build(sheet: Self.Sheet) -> Self.Body
    @ViewBuilder @MainActor func build(cover: Self.FullScreenCover) -> Self.Body
}

class Coordinator: ObservableObject {
    
    @Published var path = NavigationPath()
    @Published var sheet: Sheet?
    @Published var fullScreenCover: FullScreenCover?
    
    func push(_ page: Page) {
        path.append(page)
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popToRoo() {
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
        self.fullScreenCover = nil
    }
    
    @ViewBuilder
    func build(page: Page) -> some View {
        
    }
    
    @ViewBuilder
    func build(sheet: Sheet) -> some View {
        
    }
    
    @ViewBuilder
    func build(cover: FullScreenCover) -> some View {
        
    }
}
