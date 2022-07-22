//
//  IImageCache.swift
//  MVVMRxSwift
//
//  Created by Михаил Бойко on 21.07.2022.
//

import UIKit

protocol IImageCache: AnyObject {
    func removeAll()

    subscript(_ token: String) -> UIImage? { get set }
}
