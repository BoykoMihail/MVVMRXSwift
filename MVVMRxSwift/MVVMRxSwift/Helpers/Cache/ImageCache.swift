//
//  ImageCache.swift
//  MVVMRxSwift
//
//  Created by Михаил Бойко on 21.07.2022.
//

import UIKit

private extension Int {
    static let defaultCountLimit = 300
}

final class ImageCache {
    private lazy var imageCache: NSCache<AnyObject, UIImage> = {
        let cache = NSCache<AnyObject, UIImage>()
        cache.countLimit = countLimit
        return cache
    }()

    private let countLimit: Int

    init(countLimit: Int = Int.defaultCountLimit) {
        self.countLimit = countLimit
    }
}

extension ImageCache: IImageCache {
    func removeAll() {
        imageCache.removeAllObjects()
    }

    private func insert(_ image: UIImage?, for token: String) {
        guard let image = image else {
            remove(for: token)
            return
        }

        imageCache.setObject(image, forKey: token as AnyObject)
    }

    private func remove(for token: String) {
        imageCache.removeObject(forKey: token as AnyObject)
    }

    private func image(for token: String) -> UIImage? {
        if let image = imageCache.object(forKey: token as AnyObject) {
            return image
        }

        return nil
    }
}

extension ImageCache {
    subscript(_ token: String) -> UIImage? {
        get {
            image(for: token)
        }

        set {
            insert(newValue, for: token)
        }
    }
}
