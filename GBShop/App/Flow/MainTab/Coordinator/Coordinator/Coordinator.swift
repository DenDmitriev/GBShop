//
//  Coordinator.swift
//  GBShop
//
//  Created by Denis Dmitriev on 26.07.2023.
//

import SwiftUI

class Coordinator: CoordinatorProtocol, ObservableObject {
    
    var parent: TabCoordinatorProtocol?
    
    @Published var path = NavigationPath()
    @Published var page: Page?
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
