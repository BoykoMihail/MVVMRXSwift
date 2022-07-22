//
//  RequestError.swift
//  MVVMRxSwift
//
//  Created by Михаил Бойко on 19.07.2022.
//

import Foundation

enum RequestError: Error {
    case decodeError
    case invalidURL
    case noResponseError
    case unexpectedStatusCode
    case unknownError
    case thisIsLastPage
}
