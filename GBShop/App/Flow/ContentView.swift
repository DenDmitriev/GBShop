//
//  ContentView.swift
//  GBShop
//
//  Created by Denis Dmitriev on 22.06.2023.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @ObservedObject private var userSession = UserSession.shared

    var body: some View {
        switch userSession.isAuth {
        case true:
            MainCoordinatorView()
        case false:
            AuthView()
        }
//        Button("Crush") {
//            fatalError()
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
