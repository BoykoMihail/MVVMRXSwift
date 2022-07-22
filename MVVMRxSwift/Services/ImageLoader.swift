//
//  ImageLoader.swift
//  MVVMRxSwift
//
//  Created by Михаил Бойко on 21.07.2022.
//

import UIKit

final class ImageLoader: IImageLoader {
    // MARK: Dependency

    private var cache: IImageCache
    private let urlSession: URLSessionProtocol

    // MARK: Initialization

    init(cache: IImageCache,
         urlSession: URLSessionProtocol = URLSession.shared) {
        self.cache = cache
        self.urlSession = urlSession
    }

    // MARK: IImageLoader

    func image(from token: String) async throws -> UIImage? {
        if let cachedImage = cache[token] {
            return cachedImage
        }

        do {
            let image = try await downloadImage(from: token)
            cache[token] = image
            return image
        } catch {
            cache[token] = nil
            throw error
        }
    }
    
    // MARK: Private

    private func downloadImage(from token: String) async throws -> UIImage {
        let endpoint = AssetsImageEndpoints.assetsImage(token: token)
        
        let request = try endpoint.buildRequest()

        let (data, response) = try await urlSession.data(for: request, delegate: nil)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200,
              let image = UIImage(data: data) else {
            throw ImageLoaderCustomErrors.imageLoaderError
        }

        return image
    }
}
