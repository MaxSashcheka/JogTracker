//
//  EmptyJogsViewController.swift
//  JogTracker
//
//  Created by Max Sashcheka on 11/15/21.
//

import UIKit

class JogsViewController: UIViewController {

    enum State {
        case list
        case empty
        
        mutating func toggle() {
            switch self {
            case .empty: self = .list
            case .list: self = .empty
            }
        }
    }
    
    lazy var sadFaceImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = #imageLiteral(resourceName: "sadFace")
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    lazy var commentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()
        label.font = UIFont.sfText(28, .regular)
        label.textColor = .greyishTwo
        label.textAlignment = .center
        label.text = "Nothing is there"
        
        return label
    }()
    
    lazy var addJogButton: PurpleButton = {
        let button = PurpleButton(withCornerRadius: 30)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Create your first jog", for: .normal)
        button.setTitleColor(.babyPurple, for: .normal)
        button.addTarget(self, action: #selector(createFirstJog), for: .touchUpInside)

        return button
    }()
    
    lazy var jogsTableView: UITableView = {
        let tableView = UITableView(frame: view.bounds)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(JogStatisticTableViewCell.nib(), forCellReuseIdentifier: JogStatisticTableViewCell.reuseIdentifier)
        
        return tableView
    }()
    
    let jogsCount = 5
    var isFilterEnabled = false
    var state: State = .empty

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(sadFaceImageView)
        view.addSubview(commentLabel)
        view.addSubview(addJogButton)

        view.addSubview(jogsTableView)

        
        NSLayoutConstraint.activate([
            sadFaceImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 200),
            sadFaceImageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            
            commentLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            commentLabel.topAnchor.constraint(equalTo: sadFaceImageView.bottomAnchor, constant: 30),

            addJogButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100),
            addJogButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 60),
            addJogButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -60),
            addJogButton.heightAnchor.constraint(equalToConstant: 60),
            addJogButton.widthAnchor.constraint(equalToConstant: 200)
        ])
        
        setupNavigationBar()

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

        let filterButton = UIButton(type: .system)
        filterButton.setImage(UIImage(named: "filterDisabled"), for: .normal)
        filterButton.tintColor = .white
        filterButton.addTarget(self, action: #selector(filterHandler(sender:)), for: .touchUpInside)
        
        let menuButton = UIButton(type: .system)
        menuButton.setImage(UIImage(named: "menu"), for: .normal)
        menuButton.tintColor = .white
        menuButton.addTarget(self, action: #selector(menuHandler), for: .touchUpInside)
        
        let buttonsStackView = UIStackView(arrangedSubviews: [filterButton, menuButton])
        buttonsStackView.distribution = .equalSpacing
        buttonsStackView.axis = .horizontal
        buttonsStackView.alignment = .center
        buttonsStackView.spacing = 50
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: buttonsStackView)
        
        navigationItem.titleView = titleView
    }
    
    private func updateUI() {
        if state == .empty {
            sadFaceImageView.isHidden = false
            commentLabel.isHidden = false
            addJogButton.isHidden = false
        } else {

            sadFaceImageView.isHidden = true
            commentLabel.isHidden = true
            addJogButton.isHidden = true
        }
    }
    
    @objc func filterHandler(sender: UIButton) {
        print("filterHandler")
        isFilterEnabled = !isFilterEnabled
        if isFilterEnabled {
            sender.setImage(UIImage(named: "filterEnabled"), for: .normal)
            sender.tintColor = .sapGreen
        } else {
            sender.setImage(UIImage(named: "filterDisabled"), for: .normal)
            sender.tintColor = .white

        }
    }
    
    @objc func menuHandler() {
        print("menuHandler")
        state.toggle()
        updateUI()
//        navigationController?.popViewController(animated: true)

    }
    
    @objc private func createFirstJog() {
        let createJogViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "CreateJogViewController")
        
        self.navigationController?.pushViewController(createJogViewController, animated: true)
    }
   
}

extension JogsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jogsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: JogStatisticTableViewCell.reuseIdentifier, for: indexPath) as! JogStatisticTableViewCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    
}


