//
//  Extensions.swift
//  JogTracker
//
//  Created by Max Sashcheka on 11/15/21.
//

import UIKit

extension UIColor {
    static let babyPurple: UIColor = UIColor(red: 233.0 / 255.0, green: 144.0 / 255.0, blue: 249.0 / 255.0, alpha: 1.0)
    static let appleGreen: UIColor = UIColor(red: 126.0 / 255.0, green: 211.0 / 255.0, blue: 33.0 / 255.0, alpha: 1.0)
    
}

extension UIFont {
    enum Prettiness: String {
        case regular
        case medium
        case bold
    }
    
    static func sfText(_ size: CGFloat, _ type: Prettiness) -> UIFont {
        UIFont(name: "SFUIText-\(type.rawValue.capitalized)", size: size) ?? .systemFont(ofSize: size)
    }
}
