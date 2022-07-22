//
//  СryptocurrenciesViewAssembly.swift
//  MVVMRxSwift
//
//  Created by Михаил Бойко on 19.07.2022.
//

import UIKit

final class СryptocurrenciesViewAssembly: IСryptocurrenciesViewAssembly {
    // MARK: Dependency
    
    private let currenciesService: ICurrenciesService
    private let imageLoader: IImageLoader

    // MARK: Initialization

    init(currenciesService: ICurrenciesService,
         imageLoader: IImageLoader) {
        self.currenciesService = currenciesService
        self.imageLoader = imageLoader
    }

    // MARK: IСryptocurrenciesViewAssembly

    func assembly(moveToDetailCoordinator: MoveToDetailCoordinator) -> UIViewController {
        let viewModel = СryptocurrenciesViewModel(currenciesService: currenciesService,
                                                  imageLoader: imageLoader,
                                                  moveToDetailCoordinator: moveToDetailCoordinator)
        let viewController = СryptocurrenciesViewController()
        viewController.viewModel = viewModel

        return viewController
    }
}
