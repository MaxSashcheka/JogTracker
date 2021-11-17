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


extension UIViewController {
    
    func createCustomNavigationBar() {
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    func createCustomTitleView() -> UIView {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
        view.backgroundColor = .red
        let logoImageView = UIImageView()
        logoImageView.image = UIImage(named: "logoBear")

        view.addSubview(logoImageView)
        
        return view
    }
    
    func createCustomButton(imageName: String, selector: Selector) -> UIBarButtonItem {

        let button = UIButton(type: .system)
        button.setImage(UIImage(named: imageName), for: .normal)
        button.tintColor = .white
        button.imageView?.contentMode = .scaleAspectFit
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.addTarget(self, action: selector, for: .touchUpInside)
        
        let menuBarItem = UIBarButtonItem(customView: button)
        return menuBarItem
    }
}
