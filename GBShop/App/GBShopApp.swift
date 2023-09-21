//
//  GBShopApp.swift
//  GBShop
//
//  Created by Denis Dmitriev on 22.06.2023.
//

import SwiftUI

@main
struct GBShopApp: App {

    @ObservedObject var viewModel: GBShopAppViewModel

    init() {
        self.viewModel = GBShopAppViewModel()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    Task {
                        await viewModel.authWithToken()
                    }
                }
                .alert(isPresented: $viewModel.hasError, error: viewModel.error, actions: {})
        }
    }
}
