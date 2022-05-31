//
//  ImageLoader.swift
//  StocksApp (iOS)
//
//  Created by Mufti, Shayan on 5/27/22.
//

// downloads the image for us from the network

import Combine
import UIKit

// class for downloading image
final class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    
    private(set) var isLoading = false          // for current loading state
    
    private let url: URL
    private var cache: ImageCache?              // call ImageCache (set to optional) and store it as the cache variable
    private var cancellable: AnyCancellable?
    
    // default image process queue
    private static let imageProcessingQueue = DispatchQueue(label: "com.devtechie.imageProcessing")
    
    // our initializer which sets the url and cache
    init(url: URL, cache: ImageCache? = nil) {
        
        self.url = url
        self.cache = cache
    }
    
    // call cancel function
    deinit {
        cancel()
    }
    
    // function to load image
    func load() {
        
        // if image is already loading
        guard !isLoading else {
            return
        }
        
        // if image is not loading, then try getting it from the cache
        if let image = cache?[url] {
            self.image = image          // assign the self image to the image retrieved from the cache
            return
        }
        
        // if none, then create url session for publisher from url given
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map {UIImage(data: $0.data) }
            .replaceError(with: nil)
        
            // handles the events (functions creted for each below)
            .handleEvents(
                receiveSubscription: { [weak self] _ in self?.onStart() },
                receiveOutput: { [weak self] in self?.cache($0) },
                receiveCompletion: { [weak self] _ in self?.onFinish()},
                receiveCancel: { [weak self] in self?.onFinish() })
            .subscribe(on: Self.imageProcessingQueue)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in self?.image = $0 }
    }
    
    func onStart() {
        isLoading = true
    }
    
    func onFinish() {
        isLoading = false
    }
    
    // function for cache which takes an image
    private func cache(_ image: UIImage?) {
        // map the image
        image.map {cache?[url] = $0}
    }
    
    // function to cancel
    func cancel() {
        cancellable?.cancel()
    }
}
