//
//  AssetsResponse.swift
//  MVVMRxSwift
//
//  Created by Михаил Бойко on 20.07.2022.
//

import Foundation

struct CurrencieData: Codable {
    let id: String?
    let symbol: String?
    let metrics: Metrics?

    enum CodingKeys: String, CodingKey {
        case id
        case symbol
        case metrics
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        symbol = try values.decodeIfPresent(String.self, forKey: .symbol)
        metrics = try values.decodeIfPresent(Metrics.self, forKey: .metrics)
    }
}

struct AssetsResponse: Codable {
    let data: [CurrencieData]?

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent([CurrencieData].self, forKey: .data)
    }
}

struct Metrics: Codable {
    let marketData: MarketData?

    enum CodingKeys: String, CodingKey {
        case marketData = "market_data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        marketData = try values.decodeIfPresent(MarketData.self, forKey: .marketData)
    }
}

struct MarketData: Codable {
    let priceUsd: Double?

    enum CodingKeys: String, CodingKey {
        case priceUsd = "price_usd"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        priceUsd = try values.decodeIfPresent(Double.self, forKey: .priceUsd)
    }
}
