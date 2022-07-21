//
//  TimeSeriesResponse.swift
//  MVVMRxSwift
//
//  Created by Михаил Бойко on 21.07.2022.
//

import Foundation

public struct TimeSeriesResponse: Codable {
    let id: String?
    let sourceAttributions: [SourceAttribution]?
    let timeSeries: [TimeSeries]?

    enum DataCodingKeys: String, CodingKey {
        case data
    }
    
    enum ValuesDataCodingKeys: String, CodingKey {
        case values
        case schema
        case id
    }
    
    enum SourceAttributionCodingKeys: String, CodingKey {
        case sourceAttribution = "source_attribution"
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: DataCodingKeys.self)

        let data = try values.nestedContainer(keyedBy: ValuesDataCodingKeys.self, forKey: .data)
        
        id = try data.decodeIfPresent(String.self, forKey: .id)

        if let valuesResp = try data.decodeIfPresent([[Double]].self, forKey: .values) {
            timeSeries = valuesResp.compactMap {
                guard $0.count > 2 else {
                    return nil
                }
                
                return TimeSeries(date: "\($0[0])", price: "\($0[1])")
            }
        } else {
            timeSeries = nil
        }

        let schema = try data.nestedContainer(keyedBy: SourceAttributionCodingKeys.self, forKey: .schema)

        sourceAttributions = try schema.decodeIfPresent([SourceAttribution].self, forKey: .sourceAttribution)
    }
}

public struct TimeSeries: Codable {
    let date: String
    let price: String
}

public struct SourceAttribution: Codable {
    let name: String
    let url: String
}
