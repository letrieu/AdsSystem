//
//  UICommonValue.swift
//  ios-app
//
//  Created by TrieuLD on 28/03/2021.
//  Copyright © 2021 TrieuLD. All rights reserved.
//

import UIKit

class UICommonValue: NSObject {
    static let smallCornerRadius: CGFloat = 4
    static let cornerRadius: CGFloat = 8
    static let minSpacing: CGFloat = 8
    static let commonSpacing: CGFloat = 16
    static let smallButtonHeight: CGFloat = 30
    static let bigButtonHeight: CGFloat = 60
    static let buttonHeight: CGFloat = 44
    
    static let isIpad: Bool = UIDevice.current.userInterfaceIdiom == .pad
    
    static var isLandscape: Bool {
        get {
            return UIDevice.current.orientation.isLandscape
        }
    }
    
    static var screenWidth: CGFloat {
        get {
            return UIScreen.main.bounds.width
        }
    }
    static var screenHeight: CGFloat {
        get {
            return UIScreen.main.bounds.height
        }
    }
    
}
