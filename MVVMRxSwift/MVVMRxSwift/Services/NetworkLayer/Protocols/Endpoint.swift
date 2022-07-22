//
//  Endpoint.swift
//  MVVMRxSwift
//
//  Created by Михаил Бойко on 19.07.2022.
//

import Foundation

protocol Endpoint {
    var baseURL: String { get }
    var path: String { get }
    var queryItems: [String: String]? { get }
    var header: [String: String]? { get }
    var body: [String: String]? { get }
    var method: Method { get }
}

extension Endpoint {
    func buildRequest() throws -> URLRequest {
        guard var components = URLComponents(string: baseURL + path) else {
            throw RequestError.invalidURL
        }

        components.queryItems = queryItems?.map({ (key: String, value: String) in
            URLQueryItem(name: key, value: value)
        })

        guard let url = components.url else {
            throw RequestError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = header

        if let body = body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        }
        
        return request
    }
}
