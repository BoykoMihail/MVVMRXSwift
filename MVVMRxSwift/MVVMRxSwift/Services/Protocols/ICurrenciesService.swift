//
//  ICurrenciesService.swift
//  MVVMRxSwift
//
//  Created by Михаил Бойко on 20.07.2022.
//

import Foundation
import RxSwift

protocol ICurrenciesService {
    func fetchPhotos(page: Int) async throws -> Single<AssetsResponse>
}
