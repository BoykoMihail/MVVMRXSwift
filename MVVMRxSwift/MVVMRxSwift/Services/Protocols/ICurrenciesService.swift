//
//  ICurrenciesService.swift
//  MVVMRxSwift
//
//  Created by Михаил Бойко on 20.07.2022.
//

import Foundation
import RxSwift

public protocol ICurrenciesService {
    func fetchAssets(page: Int) async throws -> AssetsResponse
    func fetchTimeSeries(by name: String) async throws -> TimeSeriesResponse
}
