//
//  ImageLoader.swift
//  GBShop
//
//  Created by Denis Dmitriev on 09.07.2023.
//
// https://www.vadimbulavin.com/asynchronous-swiftui-image-loading-from-url-with-combine-and-swift/

import Foundation
import Combine
import SwiftUI

class ImageLoader: ObservableObject {
    
    @Published var image: UIImage?
    
    private var cache: ImageCache?
    private let url: URL
    private var cancellable = Set<AnyCancellable>()
    private(set) var isLoading = false
    private static let imageProcessingQueue = DispatchQueue(label: "app.image-processing")
    
    init(url: URL, cache: ImageCache? = nil) {
        self.url = url
        self.cache = cache
    }
    
    deinit {
        cancel()
    }
    
    func load() {
        guard !isLoading else { return }
        
        if let image = cache?[url] {
            self.image = image
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: Self.imageProcessingQueue)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .handleEvents(receiveSubscription: { [weak self] _ in self?.onStart() },
                          receiveOutput: { [weak self] image in self?.cache(image) },
                          receiveCompletion: { [weak self] _ in self?.onFinish() },
                          receiveCancel: {[weak self] in self?.onFinish() })
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] image in
                self?.image = image
            })
            .store(in: &cancellable)
    }
    
    func cancel() {
        cancellable.removeAll()
    }
    
    private func cache(_ image: UIImage?) {
        image.map { cache?[url] = $0 }
    }
    
    private func onStart() {
        isLoading = true
    }
    
    private func onFinish() {
        isLoading = false
    }
}
