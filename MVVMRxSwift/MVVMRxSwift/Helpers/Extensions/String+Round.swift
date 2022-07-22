//
//  String+Round.swift
//  MVVMRxSwift
//
//  Created by Михаил Бойко on 22.07.2022.
//

import Foundation

extension String {
    func roundIfDouble(to digit: Int) -> String {
        var result = self
        guard let priceNumber = Double(result)?.rounded() else {
            return ""
        }
        
        result = String(format: "%.\(digit)f$", priceNumber)
        return result
    }
}
