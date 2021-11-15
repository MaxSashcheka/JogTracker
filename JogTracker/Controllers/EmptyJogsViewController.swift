//
//  EmptyJogsViewController.swift
//  JogTracker
//
//  Created by Max Sashcheka on 11/15/21.
//

import UIKit

class EmptyJogsViewController: UIViewController {

    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var createFirstJogButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commentLabel.font = UIFont.sfText(28, .regular)
        commentLabel.textColor = .greyishTwo
    }
   

}
