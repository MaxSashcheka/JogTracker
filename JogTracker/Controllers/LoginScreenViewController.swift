//
//  ViewController.swift
//  JogTracker
//
//  Created by Max Sashcheka on 11/15/21.
//

import UIKit

class LoginScreenViewController: UIViewController {

    @IBOutlet weak var enterButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        enterButton.layer.cornerRadius = enterButton.frame.height / 2
        enterButton.layer.borderWidth = 3
        enterButton.layer.borderColor = UIColor.babyPurple.cgColor
        enterButton.titleLabel?.font = UIFont.sfText(20, .bold)
        enterButton.titleLabel?.tintColor = .babyPurple
        
    }


    @IBAction func enterButtonTapped(_ sender: UIButton) {
        
    }
}

