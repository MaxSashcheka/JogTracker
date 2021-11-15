//
//  InfoViewController.swift
//  JogTracker
//
//  Created by Max Sashcheka on 11/15/21.
//

import UIKit

class InfoViewController: UIViewController {

    @IBOutlet weak var infoLabel: UILabel!
    
    @IBOutlet var infoTextLabels: [UILabel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        infoTextLabels.forEach { label in
            label.font = UIFont.sfText(17.0, .regular)
        }
        infoLabel.font = UIFont.sfText(30, .bold)
        infoLabel.textColor = .appleGreen
    }
    

}
