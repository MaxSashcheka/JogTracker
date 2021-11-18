//
//  CreateJogViewController.swift
//  JogTracker
//
//  Created by Max Sashcheka on 11/15/21.
//

import UIKit

class CreateEditJogViewController: UIViewController {

    @IBOutlet weak var backgroundView: UIView!
    
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var distanceTextField: UITextField!
    @IBOutlet weak var timeTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    @available(iOS 13.4, *)
    lazy var jogDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = UIDatePickerStyle.wheels
        datePicker.datePickerMode = UIDatePicker.Mode.date
        return datePicker
    }()
    
    var selectedJog: Jog?
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        navigationController?.navigationBar.backIndicatorImage = UIImage()
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        setupBackgroundView()
        setupLabels()
        setupTextFields()
        setupButtons()
        setupTapGesture()
        fillTextFieldsWithJog()
        setupNavigationBar()
    }
    
}

// MARK: - Private interface

private extension CreateEditJogViewController {
    
    func setupNavigationBar() {

        let titleView = UIView()
        titleView.backgroundColor = .clear
        titleView.frame = .init(x: 0, y: 0, width: view.frame.width, height: 50)
        
        let logoBearImageView = UIImageView(image: UIImage(named: "logoBearWhite"))
        logoBearImageView.contentMode = .scaleAspectFit
        titleView.addSubview(logoBearImageView)

        let filterButton = UIButton(type: .system)
        filterButton.setImage(UIImage(named: "filterDisabled"), for: .normal)
        filterButton.tintColor = .white

        
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
    
    func fillTextFieldsWithJog() {
        if let jog = selectedJog {
            
            distanceTextField.text = String(Int(jog.distance))
            timeTextField.text = String(jog.time)
            
            let date = Date(timeIntervalSince1970: jog.date)
            let formatter = DateFormatter()
            formatter.dateFormat = "dd.MM.yyyy"
            if #available(iOS 13.4, *) {
                jogDatePicker.date = date
            }
            
            dateTextField.text = formatter.string(from: date)
        }
    }
    
    func setupBackgroundView() {
        backgroundView.backgroundColor = .appleGreen
        backgroundView.layer.cornerRadius = 30
        
        backgroundView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4).cgColor
        backgroundView.layer.shadowOffset = .zero
        backgroundView.layer.shadowOpacity = 1.0
        backgroundView.layer.shadowRadius = 5.0
    }
    
    func setupLabels() {
        distanceLabel.font = UIFont.sfText(15, .regular)
        dateLabel.font = UIFont.sfText(15, .regular)
        timeLabel.font = UIFont.sfText(15, .regular)

    }
    
    func setupTextFields() {
        [distanceTextField, timeTextField, dateTextField].forEach { textField in
            textField?.delegate = self
            textField?.font = UIFont.sfText(15, .regular)
            textField?.layer.borderWidth = 1.0
            textField?.layer.borderColor = UIColor.gray.cgColor
            textField?.layer.cornerRadius = 8
            textField?.layer.masksToBounds = true
        }
    
        // Setup date toolbar
        let jogingDateToolBar = UIToolbar()
        jogingDateToolBar.sizeToFit()
        let jogingDateDoneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(saveJogingdate))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        jogingDateToolBar.setItems([flexSpace, jogingDateDoneButton], animated: true)
        
        if #available(iOS 13.4, *) {
            dateTextField.inputView = jogDatePicker
        }
        dateTextField.inputAccessoryView = jogingDateToolBar

    }
    
    func setupButtons() {
        cancelButton.setImage(UIImage(named: "cancelButton"), for: .normal)
        cancelButton.tintColor = .white
        
        saveButton.backgroundColor = .clear
        saveButton.titleLabel?.font = UIFont.sfText(15, .bold)
        saveButton.layer.borderColor = UIColor.white.cgColor
        saveButton.layer.borderWidth = 2.0
        saveButton.layer.cornerRadius = saveButton.frame.height / 2
        saveButton.titleLabel?.tintColor = .white
        
    }
    
    func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self,
                         action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    @objc func saveJogingdate() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        if #available(iOS 13.4, *) {
            dateTextField.text = formatter.string(from: jogDatePicker.date)
        }
        
        view.endEditing(true)
    }
    
    @objc func menuHandler() {
        popBack(3)
    }
    

    @IBAction func cancelButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        guard let distance = distanceTextField.text, distance != "" else { return }
        guard let time = timeTextField.text, time != "" else { return }
        guard let dateString = dateTextField.text, dateString != "" else { return }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        let date = formatter.date(from: dateString)
        
        let jog = Jog(jogId: selectedJog?.jogId ?? 0, userId: "134", distance: Float(distance) ?? 0, time: Int(time) ?? 0, date: TimeInterval(date?.timeIntervalSince1970 ?? 0))
        
        if selectedJog == nil {
            NetworkManager.shared.postJog(jog) { error in
                print(error?.rawValue)
            }
        } else {
            NetworkManager.shared.updateJog(jog) { error in
                print(error?.rawValue)
            }
        }
        
        
        navigationController?.popViewController(animated: true)
    }
    
}

// MARK: - UITextFieldDelegate

extension CreateEditJogViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
