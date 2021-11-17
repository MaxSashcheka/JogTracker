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
        title = "Login"
        setupNavigationBar()
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        navigationController?.navigationBar.backIndicatorImage = UIImage()
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
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
        menuButton.addTarget(self, action: #selector(openMenuController), for: .touchUpInside)

        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: menuButton)
        
        navigationItem.titleView = titleView
    }

    @objc private func openMenuController() {
        let menuViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "MenuViewController")
        self.navigationController?.pushViewController(menuViewController, animated: true)
    }

    @IBAction func enterButtonTapped(_ sender: UIButton) {
        openMenuController()
    }
}

