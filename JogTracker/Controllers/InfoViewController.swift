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

        setupLabels()
        setupNavigationBar()
    }
    
    private func setupLabels() {
        infoTextLabels.forEach { label in
            label.font = UIFont.sfText(17.0, .regular)
        }
        infoLabel.font = UIFont.sfText(30, .bold)
        infoLabel.textColor = .appleGreen
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barTintColor = .appleGreen

    }
    
    private func setupNavigationBar() {

        let titleView = UIView()
        titleView.backgroundColor = .clear
        titleView.frame = .init(x: 0, y: 0, width: view.frame.width, height: 50)
        
        let logoBearImageView = UIImageView(image: UIImage(named: "logoBearWhite"))
        logoBearImageView.contentMode = .scaleAspectFit
        titleView.addSubview(logoBearImageView)

        let menuButton = UIButton(type: .system)
        menuButton.setImage(UIImage(named: "menu"), for: .normal)
        menuButton.tintColor = .white
        menuButton.addTarget(self, action: #selector(backToMenu), for: .touchUpInside)

        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: menuButton)
        navigationItem.backBarButtonItem?.image = UIImage(named: "logoBearWhite")
        navigationItem.titleView = titleView
    }
    
    @objc private func backToMenu() {
        navigationController?.popViewController(animated: true)
    }
    
    

}
