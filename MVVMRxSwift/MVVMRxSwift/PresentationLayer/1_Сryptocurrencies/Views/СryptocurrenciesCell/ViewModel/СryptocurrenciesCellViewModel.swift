//
//  СryptocurrenciesCellViewModel.swift
//  MVVMRxSwift
//
//  Created by Михаил Бойко on 19.07.2022.
//

import UIKit

struct СryptocurrenciesCellViewModel {
    // MARK: Dependencies
    private let imageLoader: IImageLoader
    
    // MARK: Properties

    let name: String?
    let price: String
    let token: String?

    var image: UIImage? {
        get async throws {
            guard let token = token else {
                return nil
            }
            return try await imageLoader.image(from: token)
        }
    }
    // MARK: Initialization

    init(imageLoader: IImageLoader,
         name: String?,
         price: String?,
         token: String?) {
        self.imageLoader = imageLoader
        self.name = name
        self.price = price?.roundIfDouble(to: 2) ?? ""
        self.token = token
    }
}
