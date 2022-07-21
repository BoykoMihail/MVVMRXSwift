//
//  СryptocurrenciesCellViewModel.swift
//  MVVMRxSwift
//
//  Created by Михаил Бойко on 19.07.2022.
//

import UIKit

struct СryptocurrenciesCellViewModel {
    // MARK: Properties

    let image: UIImage?
    let name: String?
    let price: String?
    let token: String?

    // MARK: Init

    init(image: UIImage?,
         name: String?,
         price: String?,
         token: String?) {
        self.image = image
        self.name = name
        self.price = price
        self.token = token
    }
}
