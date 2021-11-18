//
//  MenuListTableViewController.swift
//  JogTracker
//
//  Created by Max Sashcheka on 11/19/21.
//

import UIKit

class MenuListTableViewController: UITableViewController {
    
    var titles = ["Back to menu", "Leave feedback"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.isScrollEnabled = false
        tableView.separatorInset = .zero
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = titles[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            dismiss(animated: true, completion: nil)
        } else {
            let menuViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "FeedbackViewController")
            self.navigationController?.pushViewController(menuViewController, animated: true)
        }
    }
    
}
