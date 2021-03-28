//
//  NavigationHelper.swift
//  ios-app
//
//  Created by TrieuLD on 28/03/2021.
//  Copyright © 2021 TrieuLD. All rights reserved.
//

import UIKit

class NavigationHelper {
    class func createBarButtonItem(withImage image: UIImage?, target: Any? = nil, action: Selector? = nil) -> UIBarButtonItem {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        button.setImage(image, for: .normal)
        button.imageView?.tintColor = .black
        
        if let buttonTarget = target, let buttonAction = action {
            button.addTarget(buttonTarget, action: buttonAction, for: .touchUpInside)
        }
        
        let barItem = UIBarButtonItem()
        barItem.customView = button
        
        return barItem
    }
}
