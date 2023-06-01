//
//  CreateUserViewController.swift
//  ConnectionJustForToday
//
//  Created by Matthew Hill on 4/4/23.
//

import UIKit

class CreateUserViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    var viewModel: CreateUserViewModel!
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = CreateUserViewModel()
        self.hideKeyboardWhenDone()
    }
    
    // MARK: - fucntions
    func presentMainVC() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyBoard.instantiateViewController(identifier: "Navigation")
        viewController.modalPresentationStyle = .fullScreen
        viewController.modalTransitionStyle = .crossDissolve
        present(viewController, animated: true)
    }
    
    func presentErrorAlertController(sender: AnyObject, error: String) {
        guard let button = sender as? UIView else { return}
        let alertController = UIAlertController(title: "", message: error, preferredStyle: .actionSheet)
        let dismissAction = UIAlertAction(title: "Okay", style: .cancel)
        alertController.addAction(dismissAction)
        if let presenter = alertController.popoverPresentationController {
            presenter.sourceView = button
            presenter.sourceRect = button.bounds
        }
        present(alertController, animated: true)
    }
    
    // MARK: - Actions
    @IBAction func createUserButtonTapped(_ sender: Any) {
        guard let email = userEmailTextField.text,
              let password = userPasswordTextField.text,
              let confirmPassword = confirmPasswordTextField.text else { return }
        
        viewModel.createUser(email: email, password: password, confirmPassword: confirmPassword) { success, error in
            if success == true {
                self.presentMainVC()
            } else {
                self.presentErrorAlertController(sender: self.userEmailTextField, error: error?.localizedDescription ?? "")
            }
        }
    }
} // End of class
