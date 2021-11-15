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
    
    }


    @IBAction func enterButtonTapped(_ sender: UIButton) {
        let menuViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "MenuViewController")
        self.navigationController?.pushViewController(menuViewController, animated: true)
    }
}

