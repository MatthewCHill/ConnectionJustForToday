//
//  UserSettingsViewController.swift
//  ConnectionJustForToday
//
//  Created by Matthew Hill on 4/4/23.
//

import UIKit

class UserSettingsViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var userCountryTextField: UITextField!
    @IBOutlet weak var userCleanDateTextField: UITextField!
    
    // MARK: - Properties
    var viewModel: UserSettingViewModel!
    let datePicker = UIDatePicker()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = UserSettingViewModel(delegate: self)
        cleanTimeDatePicker()
    }
    
    // MARK: - Functions
    func cleanTimeDatePicker() {
        // adds the toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        // Adds the bar button item
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneBtn], animated: true)
        
        // Date Picker Attributes
        userCleanDateTextField.inputView = datePicker
        userCleanDateTextField.inputAccessoryView = toolbar
        userCleanDateTextField.textAlignment = .center
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
    }
    
    @objc func donePressed() {
        // Formatter for Date
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        
        userCleanDateTextField.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    func updateUI() {
        guard let userName = userNameTextField.text,
              let userCleanDate = userCleanDateTextField.text,
              let userCountry = userCountryTextField.text else {return}
        
        viewModel.saveUserSettings(userName: userName, userCountry: userCountry, cleandDate: userCleanDate)
    }
    
    
    // MARK: - Actions
    @IBAction func saveButtonTapped(_ sender: Any) {
        updateUI()
    }
} // End of class

// MARK: - Extension
extension UserSettingsViewController: UserSettingViewModelDelegate {
    func userSettingsSaved() {
        self.navigationController?.pushViewController(JFTPostViewController(), animated: true)
    }
}
