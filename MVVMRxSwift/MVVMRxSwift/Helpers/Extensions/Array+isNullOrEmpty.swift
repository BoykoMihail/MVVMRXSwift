//
//  Array+isNullOrEmpty.swift
//  MVVMRxSwift
//
//  Created by Михаил Бойко on 21.07.2022.
//

import Foundation

extension Optional where Wrapped: Collection {
    var isNullOrEmpty: Bool {
        return self?.isEmpty ?? true
    }
}
