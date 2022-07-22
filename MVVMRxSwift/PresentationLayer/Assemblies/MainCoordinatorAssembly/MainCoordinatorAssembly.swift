//
//  MainCoordinatorAssembly.swift
//  MVVMRxSwift
//
//  Created by Михаил Бойко on 22.07.2022.
//

import Foundation

final class MainCoordinatorAssembly {
    // MARK: Dependency

    private let dependencyAssembly: DependencyAssembly
    
    // MARK: Initialization

    init(dependencyAssembly: DependencyAssembly) {
        self.dependencyAssembly = dependencyAssembly
    }
    
    func assembly() -> MainCoordinator {
        MainCoordinator(navigationController: dependencyAssembly.navigationController,
                        detailsImageViewAssembly: dependencyAssembly.detailsViewAssembly,
                        cryptocurrenciesViewAssembly: dependencyAssembly.cryptocurrenciesViewAssembly)
    }
}
