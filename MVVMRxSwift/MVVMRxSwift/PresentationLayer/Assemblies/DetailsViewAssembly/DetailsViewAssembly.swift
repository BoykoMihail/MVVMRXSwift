//
//  DetailsViewAssembly.swift
//  MVVMRxSwift
//
//  Created by Михаил Бойко on 22.07.2022.
//

import SwiftUI
import UIKit

final class DetailsViewAssembly: IDetailsViewAssembly {
    // MARK: IDetailsViewAssembly
    
    func assembly(viewModel: СryptocurrenciesCellViewModel) -> UIViewController {
        let viewModel = LineChartViewModel(service: CurrenciesService(),
                                           token: viewModel.token,
                                           name: viewModel.name,
                                           price: viewModel.price)
        let view = DetailView(lineChartViewModel: viewModel)
        let viewController = UIHostingController(rootView: view)
        
        return viewController
    }
}
