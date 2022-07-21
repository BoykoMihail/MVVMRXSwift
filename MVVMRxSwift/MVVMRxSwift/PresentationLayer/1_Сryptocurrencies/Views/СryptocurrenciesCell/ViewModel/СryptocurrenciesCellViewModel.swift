//
//  СryptocurrenciesCellViewModel.swift
//  MVVMRxSwift
//
//  Created by Михаил Бойко on 19.07.2022.
//

import UIKit

struct СryptocurrenciesCellViewModel {
    // MARK: Properties

    let name: String?
    let price: String?
    let token: String?

    var image: UIImage? {
        get async throws {
            try await ImageLoader(cache: ImageCache()).image(from: token ?? "btc")
        }
    }
    // MARK: Init

    init(name: String?,
         price: String?,
         token: String?) {
        self.name = name
        self.price = price
        self.token = token
    }
}
