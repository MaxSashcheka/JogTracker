//
//  PurpleButton.swift
//  JogTracker
//
//  Created by Max Sashcheka on 11/15/21.
//

import UIKit

class PurpleButton: UIButton {

    init(withCornerRadius radius: CGFloat) {
        super.init(frame: .zero)
        setup(withRadius: radius)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup(withRadius: 30)
    }
    
    func setup(withRadius radius: CGFloat) {
        layer.cornerRadius = radius
        layer.borderWidth = 3
        layer.borderColor = UIColor.babyPurple.cgColor
        titleLabel?.font = UIFont.sfText(20, .bold)
        titleLabel?.tintColor = .babyPurple
        
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor
        layer.shadowRadius = 0
        layer.shadowOpacity = 1.0
        layer.shadowOffset = .zero
    }
    
    override var isHighlighted: Bool {
        didSet {
            UIView.transition(with: self, duration: 0.2, options: [.transitionCrossDissolve]) { [self] in
                print("fsa")
                if isHighlighted {
                    layer.shadowRadius = 2.0
                    layer.shadowColor = UIColor.babyPurple.cgColor
                } else {
                    layer.shadowRadius = 0
                }
            }
        }
    }

}
