//
//  HTTPClient.swift
//  MVVMRxSwift
//
//  Created by Михаил Бойко on 19.07.2022.
//

import Foundation

protocol HTTPClient {
    var urlSession: URLSessionProtocol { get }

    func sendRequest<T: Decodable>(endpoint: Endpoint, responseModel: T.Type) async throws -> T
}

extension HTTPClient {
    func sendRequest<T: Decodable>(endpoint: Endpoint,
                                   responseModel: T.Type)  async throws -> T {
        let request = try endpoint.buildRequest()
        
        debugPrint("BBoyko request = ", request)
        let (data, response) = try await urlSession.data(for: request, delegate: nil)

        guard let response = response as? HTTPURLResponse else {
            throw RequestError.noResponseError
        }
        switch response.statusCode {
        case 200...299:
            guard let decodedResponse = try? JSONDecoder().decode(responseModel, from: data) else {
                throw RequestError.decodeError
            }
            return decodedResponse
        default:
            throw RequestError.unexpectedStatusCode
        }
    }
}
