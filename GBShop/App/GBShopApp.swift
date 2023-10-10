//
//  GBShopApp.swift
//  GBShop
//
//  Created by Denis Dmitriev on 22.06.2023.
//

import SwiftUI
import FirebaseCore

// swiftlint:disable line_length
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
// swiftlint:enable line_length

@main
struct GBShopApp: App {

    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @ObservedObject var viewModel: GBShopAppViewModel

    init() {
        self.viewModel = GBShopAppViewModel()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    Task {
                        viewModel.log()
                        await viewModel.authWithToken()
                    }
                }
                .alert(isPresented: $viewModel.hasError, error: viewModel.error, actions: {})
        }
    }
}
