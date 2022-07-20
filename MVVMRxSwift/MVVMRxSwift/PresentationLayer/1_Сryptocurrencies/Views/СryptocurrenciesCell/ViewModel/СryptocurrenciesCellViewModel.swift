//
//  СryptocurrenciesCellViewModel.swift
//  MVVMRxSwift
//
//  Created by Михаил Бойко on 19.07.2022.
//

import UIKit
typealias GetImageblockParametr = (Task<UIImage, Never>) -> Void
typealias GetImageblock = (@escaping GetImageblockParametr) -> Void

struct СryptocurrenciesCellViewModel {
    private let getImageblock: GetImageblock

    init(getImageblock: @escaping GetImageblock) {
        self.getImageblock = getImageblock
    }

    func getImageFromUrl(completion: @escaping GetImageblockParametr) {
        getImageblock {
            completion($0)
        }
    }
}
