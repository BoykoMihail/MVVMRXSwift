//
//  GlobalAssembly.swift
//  MVVMRxSwift
//
//  Created by Михаил Бойко on 19.07.2022.
//

import UIKit

final class GlobalAssembly {
    // MARK: Dependency
    var dependencyAssembly: DependencyAssembly

    // MARK: Init

    init(dependencyAssembly: DependencyAssembly) {
        self.dependencyAssembly = dependencyAssembly
    }

    func assembly() -> UIViewController {
        let navigationController = dependencyAssembly.navigationController
        let viewModel = СryptocurrenciesViewModel(currenciesService: dependencyAssembly.currenciesService)
        let viewController = СryptocurrenciesViewController()
        viewController.viewModel = viewModel

        navigationController.viewControllers = [viewController]

        return navigationController
    }
}
