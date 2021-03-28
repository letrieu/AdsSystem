//
//  CALayer+Extensions.swift
//  ios-app
//
//  Created by TrieuLD on 28/03/2021.
//  Copyright © 2021 TrieuLD. All rights reserved.
//

import UIKit

extension CALayer {
    func applySketchShadow(
        color: UIColor = .black,
        alpha: Float = 0.5,
        x: CGFloat = 0,
        y: CGFloat = 2,
        blur: CGFloat = 4,
        spread: CGFloat = 0)
    {
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / 2.0
        if spread == 0 {
            if cornerRadius != 0 {
                shadowPath =
                    UIBezierPath(roundedRect: bounds,
                                 cornerRadius: cornerRadius).cgPath
            }
        } else {
            let dx = -spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            if cornerRadius == 0 {
                shadowPath = UIBezierPath(rect: rect).cgPath
            } else {
                shadowPath =
                    UIBezierPath(roundedRect: rect,
                                 cornerRadius: cornerRadius).cgPath
            }
        }
    }
}
