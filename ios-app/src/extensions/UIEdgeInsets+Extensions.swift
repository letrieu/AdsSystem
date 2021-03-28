//
//  UIEdgeInsets+Extensions.swift
//  ios-app
//
//  Created by TrieuLD on 28/03/2021.
//  Copyright © 2021 TrieuLD. All rights reserved.
//

import UIKit

extension UIEdgeInsets {
    
    init(inset: CGFloat) {
        self.init(top: inset, left: inset, bottom: inset, right: inset)
    }
    
    init(horizontal: CGFloat, vertical: CGFloat) {
        self.init(top: vertical, left: horizontal, bottom: vertical, right: horizontal)
    }
}
