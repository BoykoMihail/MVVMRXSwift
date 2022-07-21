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

    func fetchPhotos(page: Int) async throws -> Single<AssetsResponse> {
        let assetsResponse = try await sendRequest(
            endpoint: СryptocurrenciesEndpoints.assets(page: page),
            responseModel: AssetsResponse.self
        )

        return Single<AssetsResponse>.create { [assetsResponse] single in
            single(.success(assetsResponse))
            return Disposables.create()
        }
    }
}
