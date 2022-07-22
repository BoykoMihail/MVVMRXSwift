//
//  IImageLoader.swift
//  MVVMRxSwift
//
//  Created by Михаил Бойко on 21.07.2022.
//

import UIKit

protocol IImageLoader {
    func image(from token: String) async throws -> UIImage?
}
