//
//  СryptocurrenciesViewModel.swift
//  MVVMRxSwift
//
//  Created by m.a.boyko on 20.07.2022.
//

import Foundation
import RxCocoa
import RxSwift

final class СryptocurrenciesViewModel: IСryptocurrenciesViewModel {
    // MARK: Dependency
    private let currenciesService: ICurrenciesService

    // MARK: IСryptocurrenciesViewModel

    var cryptocurrenciesCellViewModels = BehaviorRelay<[СryptocurrenciesCellViewModel]>(value: [])

    let fetchMoreDatas = PublishSubject<Void>()
    let refreshControlAction = PublishSubject<Void>()
    let refreshControlCompelted = PublishSubject<Void>()
    let isLoadingSpinnerAvaliable = PublishSubject<Bool>()
    let title: String = "Crypto List"

    // MARK: Private Properties

    private var pageCounter = 1
    private var isPaginationRequestStillResume = false
    private var isRefreshRequstStillResume = false

    private let disposeBag = DisposeBag()

    // MARK: Init

    init(currenciesService: ICurrenciesService) {
        self.currenciesService = currenciesService
        bind()
    }

    // MARK: IСryptocurrenciesViewModel

    func didSelectCell(model: СryptocurrenciesCellViewModel) {
        debugPrint("BBoyko didSelectCell")
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

//        dummyService.fetchDatas(page: page) { [weak self] dummyResponse in
        Task {
            let models = getRepo(page: page)
            handleDummyData(data: models)
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

    func getRepo(page: Int) -> [СryptocurrenciesCellViewModel] {
        debugPrint("BBoyko page = ", page)
        return [
            СryptocurrenciesCellViewModel(image: UIImage(systemName: "arrow.clockwise.circle.fill"),
                                          name: "Efiruum",
                                          price: "12000",
                                          token: "EFI"),
            СryptocurrenciesCellViewModel(image: UIImage(systemName: "arrow.clockwise.circle.fill"),
                                          name: "Efiruum",
                                          price: "12000",
                                          token: "EFI"),
            СryptocurrenciesCellViewModel(image: UIImage(systemName: "arrow.clockwise.circle.fill"),
                                          name: "Efiruum",
                                          price: "12000",
                                          token: "EFI"),
            СryptocurrenciesCellViewModel(image: UIImage(systemName: "arrow.clockwise.circle.fill"),
                                          name: "Efiruum",
                                          price: "12000",
                                          token: "EFI"),
            СryptocurrenciesCellViewModel(image: UIImage(systemName: "arrow.clockwise.circle.fill"),
                                          name: "Efiruum",
                                          price: "12000",
                                          token: "EFI")
        ]
    }
}
