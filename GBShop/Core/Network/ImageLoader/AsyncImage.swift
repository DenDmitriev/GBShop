//
//  AsyncImage.swift
//  GBShop
//
//  Created by Denis Dmitriev on 09.07.2023.
//

import SwiftUI

struct AsyncImage: View {
    
    @StateObject private var loader: ImageLoader
    @ViewBuilder private var placeholder: some View {
        ProgressView()
    }
    
    init(url: URL) {
        _loader = StateObject(wrappedValue: ImageLoader(url: url))
    }
    
    var body: some View {
        content
            .onAppear(perform: loader.load)
    }
    
    private var content: some View {
        Group {
            if let image = loader.image {
                Image(uiImage: image)
                    .resizable()
            } else {
                placeholder
            }
        }
    }
}

struct AsyncImage_Previews: PreviewProvider {
    static var previews: some View {
        AsyncImage(url: URL(string: "https://cm.samokat.ru/processed/l/original/158334_425819778.jpg")!)
    }
}
