//
//  CurrenciesService.swift
//  MVVMRxSwift
//
//  Created by Михаил Бойко on 20.07.2022.
//

import Foundation
import RxSwift

final class CurrenciesService: HTTPClient, ICurrenciesService {
    // MARK: Dependency

    let urlSession: URLSessionProtocol

    // MARK: Init

    init(urlSession: URLSessionProtocol = URLSession.shared) {
        self.urlSession = urlSession
    }

    // MARK: ICurrenciesService
    
    func fetchAssets(page: Int) async throws -> AssetsResponse {
        try await sendRequest(
            endpoint: СryptocurrenciesEndpoints.assets(page: page),
            responseModel: AssetsResponse.self
        )
    }
    
    func fetchTimeSeries(by name: String) async throws -> TimeSeriesResponse {
        try await sendRequest(
            endpoint: СryptocurrenciesEndpoints.timeSeries(name: name),
            responseModel: TimeSeriesResponse.self
        )
    }
}
