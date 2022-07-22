//
//  AssetsResponse.swift
//  MVVMRxSwift
//
//  Created by Михаил Бойко on 20.07.2022.
//

import Foundation

public struct CurrencieData: Codable {
    let id: String?
    let symbol: String?
    let priceUsd: Double?
    let name: String?

    enum CodingKeys: String, CodingKey {
        case id
        case symbol
        case priceUsd = "metrics"
        case name
    }
    
    enum MarketDataCodingKeys: String, CodingKey {
        case marketData = "market_data"
    }
    
    enum PriceCodingKeys: String, CodingKey {
        case priceUsd = "price_usd"
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        symbol = try values.decodeIfPresent(String.self, forKey: .symbol)
        
        let metrics = try values.nestedContainer(keyedBy: MarketDataCodingKeys.self, forKey: .priceUsd)
        let priceUsdCont = try metrics.nestedContainer(keyedBy: PriceCodingKeys.self, forKey: .marketData)
        
        priceUsd = try priceUsdCont.decodeIfPresent(Double.self, forKey: .priceUsd)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }
}

public struct AssetsResponse: Codable {
    let data: [CurrencieData]?

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent([CurrencieData].self, forKey: .data)
    }
}
