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
        self.hideKeyboardWhenDone()
        cleanTimeDatePicker()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchUserInfo()
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
        
        viewModel.saveUserSettings(userName: userName, userCountry: userCountry, cleanDate: userCleanDate)
    }
    
    func fetchUserInfo(with user: User) {
        userNameTextField.text = user.name
        userCountryTextField.text = user.country
        userCleanDateTextField.text = user.cleanDate
    }
    
    func presentAlertController() {
        let alertController = UIAlertController(title: "Success!", message: "Successfully Saved", preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Okay", style: .cancel)
        alertController.addAction(dismissAction)
        present(alertController, animated: true)
    }
    
    func deleteAccountAlertWarning() {
            let alertController = UIAlertController(title: "Delete Acount", message: "This action is permanent. Are you sure you want to delete your account?", preferredStyle: .alert)
            let dismissAction = UIAlertAction(title: "Cancel", style: .cancel)
            alertController.addAction(dismissAction)
        let confirmAction = UIAlertAction(title: "Delete Account", style: .destructive) { _ in
            self.deleteAccountAlert()
        }
        alertController.addAction(confirmAction)
        self.present(alertController, animated: true)
    }
    
    func deleteAccountAlert() {
            let alertController = UIAlertController(title: "Absolutely Sure?", message: "Your account won't be able to be recovered.", preferredStyle: .alert)
            let dismissAction = UIAlertAction(title: "Cancel", style: .cancel)
            alertController.addAction(dismissAction)
            let confirmAction = UIAlertAction(title: "Delete Account", style: .destructive) { _ in
                self.viewModel.deleteUser()
            }
            alertController.addAction(confirmAction)
            self.present(alertController, animated: true)
        }
    
    // MARK: - Actions
    @IBAction func saveButtonTapped(_ sender: Any) {
        updateUI()
        presentAlertController()
    }
    
    @IBAction func signOutButtonTapped(_ sender: Any) {
        viewModel.signOut()
    }
    
    @IBAction func deleteUserButtonTapped(_ sender: Any) {
        deleteAccountAlertWarning()
    }
    
} // End of class

// MARK: - Extension
extension UserSettingsViewController: UserSettingViewModelDelegate {
    func userSettingsFetched(with user: User) {
        fetchUserInfo(with: user)
    }
    
    func userSettingsSaved() {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
