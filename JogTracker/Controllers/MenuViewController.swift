//
//  MenuViewController.swift
//  JogTracker
//
//  Created by Max Sashcheka on 11/15/21.
//

import UIKit

class MenuViewController: UIViewController {

    @IBOutlet weak var jogsButton: UIButton!
    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var contactUsButton: UIButton!
    
    @IBOutlet var buttons: [UIButton]!
    var selectedButtonIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        buttons.forEach { button in
            button.backgroundColor = .clear
            button.titleLabel?.font = UIFont.sfText(30, .bold)
            button.titleLabel?.tintColor = .black
        }

    }
    
    private func updateSelectedButton() {
        for index in buttons.indices {
            if index == selectedButtonIndex {
                buttons[index].titleLabel?.tintColor = .appleGreen
                continue
            }
            buttons[index].titleLabel?.tintColor = .black
        }
    }
    
    @IBAction func jogsButtonTapped(_ sender: UIButton) {
        selectedButtonIndex = 0
        updateSelectedButton()
        
        let emptyJogsViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "EmptyJogsViewController")
        self.navigationController?.pushViewController(emptyJogsViewController, animated: true)
    }
    
    @IBAction func infoButtonTapped(_ sender: UIButton) {
        selectedButtonIndex = 1
        updateSelectedButton()
        
        let infoViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "InfoViewController")
        self.navigationController?.pushViewController(infoViewController, animated: true)
        
    }
    
    @IBAction func contactUsButtonTapped(_ sender: UIButton) {
        selectedButtonIndex = 2
        updateSelectedButton()
        
    }
}
