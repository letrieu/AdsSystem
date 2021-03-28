/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/. */
import UIKit

protocol Themeable:  AnyObject {
    func applyTheme()
}

protocol PrivateModeUI {
    func applyUIMode(isPrivate: Bool)
}

extension UIColor {
    static var theme: Theme {
        return ThemeManager.instance.current
    }
}

enum BuiltinThemeName: String {
    case normal
    case dark
}

// Convenience reference to these normal mode colors which are used in a few color classes.
fileprivate let defaultBackground = UIColor(hex: 0xf6f9fc)
fileprivate let defaultSeparator = UIColor(hex: 0xd7d7db)
fileprivate let defaultTextAndTint = UIColor(hex: 0x2a2a2e)

class TableViewColor {
    var background: UIColor { return defaultBackground }
    var cellBackground: UIColor { return .clear }
    var cellText: UIColor { return defaultTextAndTint }
    var cellDetailText: UIColor { return .gray }
    var separator: UIColor { return defaultSeparator }
}

protocol Theme {
    var name: String { get }
    var background: UIColor { get }
    var tableView: TableViewColor { get }
    
    var colorPaletes: [UIColor] { get }
}

class NormalTheme: Theme {
    var name: String { return BuiltinThemeName.normal.rawValue }
    var background: UIColor { return defaultBackground }
    var tableView: TableViewColor { return TableViewColor() }
    
    var colorPaletes: [UIColor] {
        return [UIColor(hex: 0x75be6f),
                UIColor(hex: 0xb6d051),
                UIColor(hex: 0xbcddc7),
                UIColor(hex: 0xa7cbeb),
                UIColor(hex: 0x86b8e6)]
    }
}
