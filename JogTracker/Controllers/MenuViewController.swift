//
//  MenuViewController.swift
//  JogTracker
//
//  Created by Max Sashcheka on 11/15/21.
//

import UIKit
import SideMenu

class MenuViewController: UIViewController {

    @IBOutlet weak var jogsButton: UIButton!
    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var contactUsButton: UIButton!
    
    @IBOutlet var buttons: [UIButton]!
    var selectedButtonIndex = 0
    
    var menu: SideMenuNavigationController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menu = SideMenuNavigationController(rootViewController: MenuListTableViewController(style: .grouped))
        menu?.leftSide = true
        menu.menuWidth = view.frame.width * 0.6
        menu.isNavigationBarHidden = true
        SideMenuManager.default.leftMenuNavigationController = menu
        
        buttons.forEach { button in
            button.backgroundColor = .clear
            button.titleLabel?.font = UIFont.sfText(30, .bold)
            button.titleLabel?.tintColor = .black
        }
        
        setupNavigationBar()
        sideMenuConfig()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.barTintColor = .white
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        navigationController?.navigationBar.backIndicatorImage = UIImage()
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage()
    }
    
    
}

// MARK: - Private interface

private extension MenuViewController {
    
    func setupNavigationBar() {
        navigationItem.hidesBackButton = true
        navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")

        let titleView = UIView()
        titleView.frame = .init(x: 0, y: 0, width: view.frame.width, height: 50)
        
        let logoBearImageView = UIImageView(image: UIImage(named: "logoBearAppleGreen"))
        logoBearImageView.contentMode = .scaleAspectFit
        titleView.addSubview(logoBearImageView)
        
        let dismissButton = UIButton(type: .system)
        dismissButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        dismissButton.tintColor = .darkGray
        dismissButton.addTarget(self, action: #selector(backToLoginController), for: .touchUpInside)

        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: dismissButton)
    
        navigationItem.titleView = titleView
    }
    
    func sideMenuConfig() {
        let sideMenuVC = UIViewController()
        sideMenuVC.view.backgroundColor = .systemRed
    }
    
    func updateSelectedButton() {
        for index in buttons.indices {
            if index == selectedButtonIndex {
                buttons[index].titleLabel?.tintColor = .appleGreen
                continue
            }
            buttons[index].titleLabel?.tintColor = .black
        }
    }
    
    @objc func backToLoginController() {
        navigationController?.popViewController(animated: true)
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
        present(menu, animated: true, completion: nil)
    }
    
}


