//
//  ContentView.swift
//  GBShop
//
//  Created by Denis Dmitriev on 22.06.2023.
//

import SwiftUI
import CoreData

struct ContentView: View {

    @ObservedObject var viewModel: ContentViewModel
    @ObservedObject private var userSession = UserSession.shared

    var body: some View {
        switch userSession.isAuth {
        case true:
            MainTabView()
        case false:
            AuthView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: ContentViewModel())
    }
}
