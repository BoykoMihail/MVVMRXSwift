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
    case timeSeries(token: String)
    case profile(token: String)
}

extension СryptocurrenciesEndpoints: Endpoint {
    var baseURL: String {
        switch self {
        case .assets:
            return "https://data.messari.io/api/v1/"
        case .timeSeries:
            return "https://data.messari.io/api/v1/"
        case .profile:
            return "https://data.messari.io/api/v2/"
        }
    }
    
    var path: String {
        switch self {
        case .assets:
            return "assets"
        case let .timeSeries(token):
            return "assets/\(token)/metrics/price/time-series"
        case let .profile(token):
            return "assets/\(token)/profile"
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
            ]
        case .profile:
            return  [
                // swiftlint:disable line_length
                "fields": "id,name,profile/general/overview/tagline,profile/general/overview/project_details,profile/general/overview/official_links"
                // swiftlint:enable line_length
            ]
        }
    }

    var header: [String: String]? {
        switch self {
        case .assets, .timeSeries, .profile:
            return nil
        }
    }

    var body: [String: String]? {
        switch self {
        case .assets, .timeSeries, .profile:
            return nil
        }
    }

    var method: Method {
        switch self {
        case .assets, .timeSeries, .profile:
            return .get
        }
    }
}
