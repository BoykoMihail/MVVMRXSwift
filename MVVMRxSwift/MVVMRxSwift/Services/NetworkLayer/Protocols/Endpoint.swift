//
//  Endpoint.swift
//  MVVMRxSwift
//
//  Created by Михаил Бойко on 19.07.2022.
//

protocol Endpoint {
    var baseURL: String { get }
    var path: String { get }
    var queryItems: [String: String]? { get }
    var header: [String: String]? { get }
    var body: [String: String]? { get }
    var method: Method { get }
}

extension Endpoint {
    var baseURL: String {
        return "https://data.messari.io/api/v1/"
    }
}
