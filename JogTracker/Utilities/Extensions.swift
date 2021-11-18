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
    static let greyishTwo: UIColor = UIColor(red: 176.0 / 255.0, green: 176.0 / 255.0, blue: 176.0 / 255.0, alpha: 1.0)
    static let sapGreen: UIColor = UIColor(red: 98.0 / 255.0, green: 170.0 / 255.0, blue: 20.0 / 255.0, alpha: 1.0)
    static let warmGrey: UIColor = UIColor(red: 100.0 / 255.0, green: 100.0 / 255.0, blue: 100.0 / 255.0, alpha: 1.0)
    static let filterCellBacground: UIColor = UIColor(red: 234.0 / 255.0, green: 234.0 / 255.0, blue: 234.0 / 255.0, alpha: 1.0)

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

extension String {
    func attributedText(mediumString: String) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: self,
                                                         attributes:
                                                            [NSAttributedString.Key.font: UIFont.sfText(15, .medium),
                                                             NSAttributedString.Key.foregroundColor: UIColor.warmGrey
                                                         ])
        let boldFontAttribute: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: UIFont.sfText(15, .medium),
            NSAttributedString.Key.foregroundColor: UIColor.black
        ]
        let range = (self as NSString).range(of: mediumString)
        attributedString.addAttributes(boldFontAttribute, range: range)
        return attributedString
    }
}

extension UIViewController {
    func popBack(_ nb: Int) {
        if let viewControllers: [UIViewController] = self.navigationController?.viewControllers {
            guard viewControllers.count < nb else {
                self.navigationController?.popToViewController(viewControllers[viewControllers.count - nb], animated: true)
                return
            }
        }
    }
}
