//
//  DependencyAssembly.swift
//  MVVMRxSwift
//
//  Created by Михаил Бойко on 19.07.2022.
//

import UIKit

final class DependencyAssembly {
    lazy var navigationController = UINavigationController()

    lazy var currenciesService: ICurrenciesService = {
        CurrenciesService()
    }()
    
    lazy var imageCache: IImageCache = {
        ImageCache()
    }()
    
    lazy var imageLoader: IImageLoader = {
        ImageLoader(cache: imageCache)
    }()
    
    lazy var detailsViewAssembly: IDetailsViewAssembly = {
        DetailsViewAssembly()
    }()
    
    lazy var cryptocurrenciesViewAssembly: IСryptocurrenciesViewAssembly = {
        СryptocurrenciesViewAssembly(currenciesService: currenciesService, imageLoader: imageLoader)
    }()
}
