//
//  СryptocurrenciesViewModel.swift
//  MVVMRxSwift
//
//  Created by m.a.boyko on 20.07.2022.
//

import Foundation
import RxCocoa
import RxSwift

protocol MoveToDetailCoordinator {
    func moveToDetail(viewModel: СryptocurrenciesCellViewModel)
}

final class СryptocurrenciesViewModel: IСryptocurrenciesViewModel {
    // MARK: Dependency
    private let currenciesService: ICurrenciesService
    private let imageLoader: IImageLoader
    private let moveToDetailCoordinator: MoveToDetailCoordinator
    
    // MARK: IСryptocurrenciesViewModel - Models

    var cryptocurrenciesCellViewModels = BehaviorRelay<[СryptocurrenciesCellViewModel]>(value: [])

    // MARK: IСryptocurrenciesViewModel - Pagination
    
    let fetchMoreDatas = PublishSubject<Void>()
    let refreshControlAction = PublishSubject<Void>()
    let refreshControlCompelted = PublishSubject<Void>()
    let isLoadingSpinnerAvaliable = PublishSubject<Bool>()
    let title: String = "Crypto List"

    // MARK: Private Properties

    private var pageCounter = 1
    private var isPaginationRequestStillResume = false
    private var isRefreshRequstStillResume = false

    // MARK: Private Constant

    private let disposeBag = DisposeBag()

    // MARK: Initialization

    init(currenciesService: ICurrenciesService,
         imageLoader: IImageLoader,
         moveToDetailCoordinator: MoveToDetailCoordinator) {
        self.currenciesService = currenciesService
        self.imageLoader = imageLoader
        self.moveToDetailCoordinator = moveToDetailCoordinator
        bind()
    }

    // MARK: IСryptocurrenciesViewModel

    func didSelectCell(model: СryptocurrenciesCellViewModel) {
        moveToDetailCoordinator.moveToDetail(viewModel: model)
    }

    // MARK: Private

    private func bind() {
        fetchMoreDatas.subscribe { [weak self] _ in
            guard let self = self else { return }
            self.fetchDummyData(page: self.pageCounter,
                                isRefreshControl: false)
        }
        .disposed(by: disposeBag)

        refreshControlAction.subscribe { [weak self] _ in
            self?.refreshControlTriggered()
        }
        .disposed(by: disposeBag)
    }

    private func fetchDummyData(page: Int, isRefreshControl: Bool) {
        if isPaginationRequestStillResume || isRefreshRequstStillResume { return }
        self.isRefreshRequstStillResume = isRefreshControl

        isPaginationRequestStillResume = true
        isLoadingSpinnerAvaliable.onNext(true)

        if pageCounter == 1 || isRefreshControl {
            isLoadingSpinnerAvaliable.onNext(false)
        }

        Task {
            let data = try await currenciesService
                .fetchAssets(page: page)
                .data?.map(buildСryptocurrenciesCellViewModel)
            
            guard let data = data else { return }
            
            handleDummyData(data: data)
            isLoadingSpinnerAvaliable.onNext(false)
            isPaginationRequestStillResume = false
            isRefreshRequstStillResume = false
            refreshControlCompelted.onNext(())
        }
    }

    private func handleDummyData(data: [СryptocurrenciesCellViewModel]) {
        if pageCounter == 1 {
            cryptocurrenciesCellViewModels.accept(data)
        } else {
            let oldDatas = cryptocurrenciesCellViewModels.value
            cryptocurrenciesCellViewModels.accept(oldDatas + data)
        }
        pageCounter += 1
    }

    private func refreshControlTriggered() {
        isPaginationRequestStillResume = false
        pageCounter = 1
        cryptocurrenciesCellViewModels.accept([])
        fetchDummyData(page: pageCounter,
                       isRefreshControl: true)
    }
    
    private func buildСryptocurrenciesCellViewModel(response: CurrencieData) -> СryptocurrenciesCellViewModel {
        let priceUsd = response.priceUsd ?? 0

        return СryptocurrenciesCellViewModel(imageLoader: imageLoader,
                                             name: response.name,
                                             price: "\(priceUsd)",
                                             token: response.symbol)
    }
}
