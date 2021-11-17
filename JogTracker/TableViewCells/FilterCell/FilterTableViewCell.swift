//
//  FilterTableViewCell.swift
//  JogTracker
//
//  Created by Max Sashcheka on 11/17/21.
//

import UIKit

class FilterTableViewCell: UITableViewCell {

    static let reuseIdentifier = "FilterTableViewCell"
    
    @IBOutlet var labels: [UILabel]!
    
    @IBOutlet weak var dateFromTextField: UITextField!
    @IBOutlet weak var dateToTextField: UITextField!
    
    lazy var dateFromPicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = UIDatePickerStyle.wheels
        datePicker.datePickerMode = UIDatePicker.Mode.date
        return datePicker
    }()
    
    lazy var dateToPicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = UIDatePickerStyle.wheels
        datePicker.datePickerMode = UIDatePicker.Mode.date
        return datePicker
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = .filterCellBacground
        labels.forEach { label in
            label.font = UIFont.sfText(14, .regular)
            label.textColor = .warmGrey
        }
        
        
        setupTextFields()
        
        
    }
    
    func setupTextFields() {
        [dateFromTextField, dateToTextField].forEach { textField in
            textField?.font = UIFont.sfText(13, .medium)
            textField?.layer.borderWidth = 1.0
            textField?.layer.borderColor = UIColor.warmGrey.cgColor
            textField?.layer.cornerRadius = 10
            textField?.layer.masksToBounds = true
            
            textField?.textColor = .warmGrey
            textField?.textAlignment = .center
        }
        
        //dateFromTextField
        let dateFromToolBar = UIToolbar()
        dateFromToolBar.sizeToFit()
        let dateFromDoneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(saveDateFrom))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        dateFromToolBar.setItems([flexSpace, dateFromDoneButton], animated: true)
        
        dateFromTextField.inputView = dateFromPicker
        dateFromTextField.inputAccessoryView = dateFromToolBar
        
        //dateToTextField
        let dateToToolBar = UIToolbar()
        dateToToolBar.sizeToFit()
        let dateToDoneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(saveDateTo))
        dateToToolBar.setItems([flexSpace, dateToDoneButton], animated: true)
        
        dateToTextField.inputView = dateToPicker
        dateToTextField.inputAccessoryView = dateToToolBar
        
        
    }
    
    @objc private func saveDateFrom() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        dateFromTextField.text = formatter.string(from: dateFromPicker.date)
        
        endEditing(true)
    }
    
    @objc private func saveDateTo() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        dateToTextField.text = formatter.string(from: dateToPicker.date)
        
        endEditing(true)
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "FilterTableViewCell", bundle: nil)
    }

    
    
}
