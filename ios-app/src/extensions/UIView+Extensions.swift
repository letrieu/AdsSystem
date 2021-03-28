//
//  UIView+Extensions.swift
//  ios-app
//
//  Created by TrieuLD on 28/03/2021.
//  Copyright © 2021 TrieuLD. All rights reserved.
//

import UIKit

extension UIView {
    var left: CGFloat {
        get {
            return frame.origin.x
        }
        set {
            frame.origin.x = newValue
        }
    }
    
    var top: CGFloat {
        get {
            return frame.origin.y
        }
        set {
            frame.origin.y = newValue
        }
    }

    var right: CGFloat {
        get {
            return left + width
        }
        set {
            left = newValue - width
        }
    }

    var bottom: CGFloat {
        get {
            return top + height
        }
        set {
            top = newValue - height
        }
    }

    var width: CGFloat {
        get {
            return bounds.width
        }
        set {
            frame.size.width = newValue
        }
    }
    
    var height: CGFloat {
        get {
            return bounds.height
        }
        set {
            frame.size.height = newValue
        }
    }
    
    var debugID: String? {
        get {
            return accessibilityIdentifier
        }
        set {
            accessibilityIdentifier = newValue
        }
    }
}
