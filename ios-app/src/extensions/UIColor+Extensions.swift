//
//  UIColor+Extensions.swift
//  ios-app
//
//  Created by TrieuLD on 28/03/2021.
//  Copyright © 2021 TrieuLD. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")

        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }

    convenience init(hex: Int) {
        self.init(
            red: (hex >> 16) & 0xFF,
            green: (hex >> 8) & 0xFF,
            blue: hex & 0xFF
        )
    }
    
    class func randomColorWithString(_ text: String) -> UIColor {
        let colorIndex = abs(text.hashValue) % self.theme.colorPaletes.count
        return self.theme.colorPaletes[colorIndex]
    }
}
