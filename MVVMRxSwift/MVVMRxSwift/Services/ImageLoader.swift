//
//  ImageLoader.swift
//  MVVMRxSwift
//
//  Created by Михаил Бойко on 21.07.2022.
//

import UIKit

final class ImageLoader: IImageLoader {
    private var cache: IImageCache
    private let urlSession: URLSessionProtocol

    init(cache: IImageCache,
         urlSession: URLSessionProtocol = URLSession.shared) {
        self.cache = cache
        self.urlSession = urlSession
    }

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

    private func downloadImage(from token: String) async throws -> UIImage {
        let endpoint = AssetsImageEndpoints.assetsImage(token: token)
        
        guard var components = URLComponents(string: endpoint.baseURL + endpoint.path) else {
            throw RequestError.invalidURL
        }

        components.queryItems = endpoint.queryItems?.map({ (key: String, value: String) in
            URLQueryItem(name: key, value: value)
        })

        guard let url = components.url else {
            throw RequestError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.header

        if let body = endpoint.body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        }

        let (data, response) = try await urlSession.data(for: request, delegate: nil)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200,
              let image = UIImage(data: data) else {
            throw ImageLoaderCustomErrors.imageLoaderError
        }

        return image
    }
}
