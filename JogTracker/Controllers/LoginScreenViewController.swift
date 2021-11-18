//
//  ViewController.swift
//  JogTracker
//
//  Created by Max Sashcheka on 11/15/21.
//

import UIKit
import KeychainAccess

class LoginScreenViewController: UIViewController {

    @IBOutlet weak var enterButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Login"
        setupNavigationBar()
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.barTintColor = .appleGreen
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        navigationController?.navigationBar.backIndicatorImage = UIImage()
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage()
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
        NetworkManager.shared.authorize(withUUID: "hello") { result in
            switch result {
            case .success(let loginResponce):
                let keychain = Keychain(service: "com.rollingscopesschoolstudent.JogTracker")
                keychain["accessToken"] = loginResponce.response.accessToken
                keychain["tokenType"] = loginResponce.response.tokenType
            case .failure(let error):
                print(error)
            }
        }
        openMenuController()

    }
    
}

