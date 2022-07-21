//
//  UIColor+Hex.swift
//  MVVMRxSwift
//
//  Created by m.a.boyko on 20.07.2022.
//

import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")

        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }

    convenience init(hex: String) {
        let rgbValue: UInt64 = 0
        let redColor = (rgbValue & 0xff0000) >> 16
        let greenColor = (rgbValue & 0xff00) >> 8
        let blueColor = rgbValue & 0xff

        self.init(
            red: CGFloat(redColor) / 0xff,
            green: CGFloat(greenColor) / 0xff,
            blue: CGFloat(blueColor) / 0xff, alpha: 1
        )
    }
}
