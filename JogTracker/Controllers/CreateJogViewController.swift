//
//  CreateJogViewController.swift
//  JogTracker
//
//  Created by Max Sashcheka on 11/15/21.
//

import UIKit

class CreateJogViewController: UIViewController {

    @IBOutlet weak var backgroundView: UIView!
    
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var distanceTextField: UITextField!
    @IBOutlet weak var timeTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    lazy var jogDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = UIDatePickerStyle.wheels
        datePicker.datePickerMode = UIDatePicker.Mode.date
        return datePicker
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupBackgroundView()
        setupLabels()
        setupTextFields()
        setupButtons()
    }
    
    
    
}

// MARK: - Private interface

private extension CreateJogViewController {
    
    private func setupBackgroundView() {
        backgroundView.backgroundColor = .appleGreen
        backgroundView.layer.cornerRadius = 30
        
        backgroundView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.33).cgColor
        backgroundView.layer.shadowOffset = .zero
        backgroundView.layer.shadowOpacity = 1.0
        backgroundView.layer.shadowRadius = 10.0
    }
    
    private func setupLabels() {
        distanceLabel.font = UIFont.sfText(15, .regular)
        dateLabel.font = UIFont.sfText(15, .regular)
        timeLabel.font = UIFont.sfText(15, .regular)

    }
    
    private func setupTextFields() {
        [distanceTextField, timeTextField, dateTextField].forEach { textField in
            textField?.font = UIFont.sfText(15, .regular)
            textField?.layer.borderWidth = 1.0
            textField?.layer.borderColor = UIColor.gray.cgColor
            textField?.layer.cornerRadius = 8
            textField?.layer.masksToBounds = true
        }
    
//        distanceTextField.font = UIFont.sfText(15, .regular)
//        distanceTextField.layer.borderWidth = 1.0
//        distanceTextField.layer.borderColor = UIColor.gray.cgColor
//        distanceTextField.layer.cornerRadius = 8
//        distanceTextField.layer.masksToBounds = true
//
//        timeTextField.font = UIFont.sfText(15, .regular)
//        timeTextField.layer.borderWidth = 1.0
//        timeTextField.layer.borderColor = UIColor.gray.cgColor
//        timeTextField.layer.cornerRadius = 8
//        timeTextField.layer.masksToBounds = true
//
//        dateTextField.font = UIFont.sfText(15, .regular)
//        dateTextField.layer.borderWidth = 1.0
//        dateTextField.layer.borderColor = UIColor.gray.cgColor
//        dateTextField.layer.cornerRadius = 8
//        dateTextField.layer.masksToBounds = true
        
        // Setup date toolbar
        let jogingDateToolBar = UIToolbar()
        jogingDateToolBar.sizeToFit()
        let jogingDateDoneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(saveJogingdate))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        jogingDateToolBar.setItems([flexSpace, jogingDateDoneButton], animated: true)
        
        dateTextField.inputView = jogDatePicker
        dateTextField.inputAccessoryView = jogingDateToolBar

    }
    
    private func setupButtons() {
        cancelButton.setImage(UIImage(named: "cancelButton"), for: .normal)
        cancelButton.tintColor = .white
        
        saveButton.backgroundColor = .clear
        saveButton.titleLabel?.font = UIFont.sfText(15, .bold)
        saveButton.layer.borderColor = UIColor.white.cgColor
        saveButton.layer.borderWidth = 2.0
        saveButton.layer.cornerRadius = saveButton.frame.height / 2
        saveButton.titleLabel?.tintColor = .white
        
    }
    
    @objc func saveJogingdate() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        dateTextField.text = formatter.string(from: jogDatePicker.date)
        
        view.endEditing(true)
    }
    

    @IBAction func cancelButtonTapped(_ sender: Any) {
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        let jogsViewController = JogsViewController()
        navigationController?.pushViewController(jogsViewController, animated: true)
    }
    
}
