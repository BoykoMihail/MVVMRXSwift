//
//  MainCoordinator.swift
//  MVVMRxSwift
//
//  Created by Михаил Бойко on 22.07.2022.
//

import UIKit

final class MainCoordinator: Coordinator {
    // MARK: Dependency

    private let navigationController: UINavigationController
    private let detailsImageViewAssembly: IDetailsViewAssembly
    private let cryptocurrenciesViewAssembly: IСryptocurrenciesViewAssembly
    
    // MARK: Initialization
    
    init(navigationController: UINavigationController,
         detailsImageViewAssembly: IDetailsViewAssembly,
         cryptocurrenciesViewAssembly: IСryptocurrenciesViewAssembly) {
        self.navigationController = navigationController
        self.detailsImageViewAssembly = detailsImageViewAssembly
        self.cryptocurrenciesViewAssembly = cryptocurrenciesViewAssembly
    }
    
    // MARK: Coordinator

    func start() {
        let viewController = cryptocurrenciesViewAssembly.assembly(moveToDetailCoordinator: self)
        navigationController.viewControllers = [viewController]
    }
}

extension MainCoordinator: MoveToDetailCoordinator {
    // MARK: MoveToDetailCoordinator
    
    func moveToDetail(viewModel: СryptocurrenciesCellViewModel) {
        let viewController = detailsImageViewAssembly.assembly(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
}
