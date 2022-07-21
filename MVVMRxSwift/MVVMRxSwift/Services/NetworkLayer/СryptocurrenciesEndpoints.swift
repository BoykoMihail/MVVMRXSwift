//
//  СryptocurrenciesEndpoints.swift
//  MVVMRxSwift
//
//  Created by Михаил Бойко on 19.07.2022.
//

import Foundation

private struct Const {
    static let defaultLimit = 20
}

enum СryptocurrenciesEndpoints {
    case assets(page: Int)
}

extension СryptocurrenciesEndpoints: Endpoint {
    var path: String {
        switch self {
        case .assets:
            return "assets"
        }
    }

    var queryItems: [String: String]? {
        switch self {
        case let .assets(page):
            return [
                "fields": "id,name,symbol,metrics/market_data/price_usd",
                "page": "\(page)",
                "limit": "\(Const.defaultLimit)"
            ]
        }
    }

    var header: [String: String]? {
        switch self {
        case .assets:
            return nil
        }
    }

    var body: [String: String]? {
        switch self {
        case .assets:
            return nil
        }
    }

    var method: Method {
        switch self {
        case .assets:
            return .get
        }
    }
}
