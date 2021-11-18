//
//  FeedbackViewController.swift
//  JogTracker
//
//  Created by Max Sashcheka on 11/19/21.
//

import UIKit

class FeedbackViewController: UIViewController {
    
    @IBOutlet weak var topicIdLabel: UILabel!
    @IBOutlet weak var feedbackCommentLabel: UILabel!
    
    @IBOutlet weak var topicPickerSegmentedControl: UISegmentedControl!
    @IBOutlet weak var feedbackTextView: UITextView!
    
    @IBOutlet weak var sendFeedbackButton: PurpleButton!
}

// MARK: - ViewController overrides

extension FeedbackViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barTintColor = .appleGreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupLabels()
        setupTextField()
        setupTextView()
        setupNavigationBar()
        setupTapGesture()
    }
}


// MARK: - Private interface

private extension FeedbackViewController {
    
    func setupLabels() {
        [topicIdLabel, feedbackCommentLabel].forEach { label in
            label?.font = UIFont.sfText(18, .medium)
            label?.textColor = .black
        }
    }
    
    func setupTextField() {
        topicPickerSegmentedControl.selectedSegmentTintColor = .appleGreen
        topicPickerSegmentedControl.layer.borderWidth = 1
        topicPickerSegmentedControl.layer.borderColor = UIColor.darkGray.cgColor
    }
    
    func setupTextView() {
        feedbackTextView.font = UIFont.sfText(18, .medium)
        feedbackTextView.textColor = .warmGrey
        feedbackTextView.clipsToBounds = false
        feedbackTextView.layer.cornerRadius = 30
        feedbackTextView.backgroundColor = .systemGroupedBackground
        feedbackTextView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func setupNavigationBar() {
        
        let titleLabel = UILabel()
        let attributes: [NSAttributedString.Key : AnyObject] = [NSAttributedString.Key.font: UIFont.sfText(25, .bold),
                                                                NSAttributedString.Key.foregroundColor: UIColor.white]
        titleLabel.attributedText = NSAttributedString(string: "Leave feedback", attributes: attributes)
        titleLabel.sizeToFit()
        navigationItem.titleView = titleLabel
        
        navigationItem.hidesBackButton = true
        
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
        
        navigationItem.titleView = titleView
    }
    
    func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self,
                         action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func backToMenu() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func sendFeedback(_ sender: PurpleButton) {
        var topicId = 0
        switch topicPickerSegmentedControl.selectedSegmentIndex {
        case 0: topicId = 1
        case 1: topicId = 2
        case 2: topicId = 3
        case 3: topicId = 5
        case 4: topicId = 8
        default:
            topicId = 0
        }
        guard let text = feedbackTextView.text, text != "" else { return }

        
        NetworkManager.shared.postFeedback(withTopicId: topicId, text: text) { error in
            print(error)
        }
        backToMenu()
    }
    
    
}

// MARK: - UITextViewDelegate

extension FeedbackViewController: UITextViewDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
