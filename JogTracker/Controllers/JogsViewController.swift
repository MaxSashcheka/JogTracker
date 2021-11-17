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
        tableView.register(FilterTableViewCell.nib(), forCellReuseIdentifier: FilterTableViewCell.reuseIdentifier)
        
        return tableView
    }()
    
    lazy var addButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "addButton"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(addJog), for: .touchUpInside)
        
        return button
    }()
    
    
    
    
    var jogs = [Jog]()
    var isFilterEnabled = false
    var state: State = .empty

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(sadFaceImageView)
        view.addSubview(commentLabel)
        view.addSubview(addJogButton)

        view.addSubview(jogsTableView)
        view.addSubview(addButton)

        NSLayoutConstraint.activate([
            sadFaceImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 200),
            sadFaceImageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            
            commentLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            commentLabel.topAnchor.constraint(equalTo: sadFaceImageView.bottomAnchor, constant: 30),

            addJogButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100),
            addJogButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 60),
            addJogButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -60),
            addJogButton.heightAnchor.constraint(equalToConstant: 60),
            addJogButton.widthAnchor.constraint(equalToConstant: 200),
            
            addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            addButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30)
        ])

        updateUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.barTintColor = .appleGreen
        
        NetworkManager.shared.fetchJogs { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let responce):
                let jogs = responce.response.jogs
                self.state = .list
                if jogs.isEmpty {
                    self.state = .empty
                } else {
                    self.state = .list
                    self.jogs = jogs
                }
                self.updateUI()
                
            case .failure(let error):
                self.state = .empty
                print(error.rawValue)
            }
        }
    }
    
    private func setupTextFields() {
        
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
        
        if state == .list {
            let buttonsStackView = UIStackView(arrangedSubviews: [filterButton, menuButton])
            buttonsStackView.distribution = .equalSpacing
            buttonsStackView.axis = .horizontal
            buttonsStackView.alignment = .center
            buttonsStackView.spacing = 50
            navigationItem.rightBarButtonItem = UIBarButtonItem(customView: buttonsStackView)
        } else {
            navigationItem.rightBarButtonItem = UIBarButtonItem(customView: menuButton)

        }
        
        navigationItem.titleView = titleView
    }
    
    private func updateUI() {
        if state == .empty {
            sadFaceImageView.isHidden = false
            commentLabel.isHidden = false
            addJogButton.isHidden = false
            
            jogsTableView.isHidden = true
            addButton.isHidden = true
            
        } else {
            sadFaceImageView.isHidden = true
            commentLabel.isHidden = true
            addJogButton.isHidden = true
            
            jogsTableView.isHidden = false
            addButton.isHidden = false

            jogsTableView.reloadData()
        }
        setupNavigationBar()
        
    }
    
    @objc func filterHandler(sender: UIButton) {
        isFilterEnabled = !isFilterEnabled
        if isFilterEnabled {
            sender.setImage(UIImage(named: "filterEnabled"), for: .normal)
            sender.tintColor = .sapGreen
        } else {
            sender.setImage(UIImage(named: "filterDisabled"), for: .normal)
            sender.tintColor = .white
        }
        let indexPathToChange = IndexPath(row: 0, section: 0)
        
        jogsTableView.beginUpdates()
        if isFilterEnabled {
            jogsTableView.insertRows(at: [indexPathToChange], with: .automatic)
        } else {
            jogsTableView.deleteRows(at: [indexPathToChange], with: .automatic)

        }
        jogsTableView.endUpdates()
    }
    
    @objc func menuHandler() {
        navigationController?.popViewController(animated: true)

    }
    
    @objc private func createFirstJog() {
        let createJogViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "CreateEditJogViewController")
        
        self.navigationController?.pushViewController(createJogViewController, animated: true)
    }
    
    @objc private func addJog() {
        let createJogViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "CreateEditJogViewController")
        
        self.navigationController?.pushViewController(createJogViewController, animated: true)
    }
   
}

extension JogsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFilterEnabled {
            return jogs.count + 1
        }
        return jogs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isFilterEnabled {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: FilterTableViewCell.reuseIdentifier, for: indexPath)
                
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: JogStatisticTableViewCell.reuseIdentifier, for: indexPath) as! JogStatisticTableViewCell
                
                let jog = jogs[indexPath.row - 1]
                cell.setup(withJog: jog)
                return cell
            }
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: JogStatisticTableViewCell.reuseIdentifier, for: indexPath) as! JogStatisticTableViewCell
            
            let jog = jogs[indexPath.row]
            cell.setup(withJog: jog)
            return cell
        }
        
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if isFilterEnabled, indexPath.row == 0 {
            return 60
        }
        return 120
    }
    
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            
            let jogId = jogs[indexPath.row].jogId
            NetworkManager.shared.deleteJog(withId: jogId)
            jogs.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            tableView.endUpdates()
        }
    }
}


