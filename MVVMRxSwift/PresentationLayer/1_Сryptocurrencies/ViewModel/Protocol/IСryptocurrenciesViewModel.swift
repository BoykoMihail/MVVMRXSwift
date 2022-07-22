//
//  IСryptocurrenciesViewModel.swift
//  MVVMRxSwift
//
//  Created by m.a.boyko on 20.07.2022.
//

import Foundation
import RxCocoa
import RxSwift

protocol IСryptocurrenciesViewModel {
    var cryptocurrenciesCellViewModels: BehaviorRelay<[СryptocurrenciesCellViewModel]> { get }
    var fetchMoreDatas: PublishSubject<Void> { get }
    var refreshControlAction: PublishSubject<Void> { get }
    var isLoadingSpinnerAvaliable: PublishSubject<Bool> { get }
    var refreshControlCompelted: PublishSubject<Void> { get }

    var title: String { get }

    func didSelectCell(model: СryptocurrenciesCellViewModel)
}
