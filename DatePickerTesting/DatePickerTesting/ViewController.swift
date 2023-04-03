//
//  ViewController.swift
//  DatePickerTesting
//
//  Created by Matthew Hill on 3/29/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var dateTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let date = Date()
//        let formatter = DateFormatter()
//        formatter.dateFormat = "MM/dd/yyyy"
//        dateTextField.text = formatter.string(from: date)
//        dateTextField.textColor = .black
        createDatePicker()
//
    }
    
    let datePicker = UIDatePicker()
//    datePicker.datePickerMode = .date
//    datePicker.addTarget(self, action: #selector(datePickerValueChanged(datePicker: )), for: UIControl.Event.valueChanged)
//    datePicker.frame.size = CGSize(width: 0, height: 300)
//    datePicker.preferredDatePickerStyle = .automatic
//    datePicker.maximumDate = Date()
    
    func createDatePicker() {
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: nil)
        
        dateTextField.inputAccessoryView = toolbar
        
        dateTextField.inputView = datePicker
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
    }
    
//    @objc func datePickerValueChanged(datePicker: UIDatePicker) {
//        dateTextField.text = formatDate(date: datePicker.date)
//
//    }
//
//    func formatDate(date: Date) -> String {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "MM/dd/yyyy"
//        return formatter.string(from: date)
//    }


}

