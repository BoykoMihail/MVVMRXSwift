//
//  AssetsImageEndpoints.swift
//  MVVMRxSwift
//
//  Created by Михаил Бойко on 21.07.2022.
//

import Foundation

enum AssetsImageEndpoints {
    case assetsImage(token: String)
}

// https://assets.coincap.io/assets/icons/leo@2x.png

extension AssetsImageEndpoints: Endpoint {
    var baseURL: String {
        return "https://assets.coincap.io/"
    }
    
    var path: String {
        switch self {
        case let .assetsImage(token):
            return "assets/icons/" + "\(token.lowercased())" + "@2x.png"
        }
    }

    var queryItems: [String: String]? {
        switch self {
        case .assetsImage:
            return nil
        }
    }

    var header: [String: String]? {
        switch self {
        case .assetsImage:
            return nil
        }
    }

    var body: [String: String]? {
        switch self {
        case .assetsImage:
            return nil
        }
    }

    var method: Method {
        switch self {
        case .assetsImage:
            return .get
        }
    }
}
