//
//  GlobalAssembly.swift
//  MVVMRxSwift
//
//  Created by Михаил Бойко on 19.07.2022.
//

import UIKit

final class GlobalAssembly {
    var dependencyAssembly: DependencyAssembly
    
    init(dependencyAssembly: DependencyAssembly) {
        self.dependencyAssembly = dependencyAssembly
    }
    
    func assembly() -> UIViewController {
        let navigationController = dependencyAssembly.navigationController
        navigationController.viewControllers = [СryptocurrenciesController()]

        return navigationController
    }
}
