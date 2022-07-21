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
    case timeSeries(name: String)
}

extension СryptocurrenciesEndpoints: Endpoint {
    var path: String {
        switch self {
        case .assets:
            return "assets"
        case let .timeSeries(name):
            return "assets/\(name)/metrics/price/time-series"
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
        case .timeSeries:
            return  [
                "after": "2022-01-01",
                "interval": "1d"
//                "timestamp-format": "rfc3339"
            ]
        }
    }

    var header: [String: String]? {
        switch self {
        case .assets, .timeSeries:
            return nil
        }
    }

    var body: [String: String]? {
        switch self {
        case .assets, .timeSeries:
            return nil
        }
    }

    var method: Method {
        switch self {
        case .assets, .timeSeries:
            return .get
        }
    }
}
