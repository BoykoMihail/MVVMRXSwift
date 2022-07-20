//
//  CurrenciesService.swift
//  MVVMRxSwift
//
//  Created by Михаил Бойко on 20.07.2022.
//

import Foundation

final class CurrenciesService: HTTPClient, ICurrenciesService {
    let urlSession: URLSessionProtocol
    
    init(urlSession: URLSessionProtocol = URLSession.shared) {
        self.urlSession = urlSession
    }

    func fetchPhotos(page: Int) async throws -> AssetsResponse {
        return try await sendRequest(
            endpoint: СryptocurrenciesEndpoints.assets(page: page),
            responseModel: AssetsResponse.self
        )
    }
}
