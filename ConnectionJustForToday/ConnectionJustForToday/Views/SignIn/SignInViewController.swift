//
//  SignInViewController.swift
//  ConnectionJustForToday
//
//  Created by Matthew Hill on 4/19/23.
//

import UIKit

class SignInViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    // MARK: - Properties
    var viewModel: SignInUserViewModel!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = SignInUserViewModel()
        self.hideKeyboardWhenDone()
    }
    
    
    // MARK: - Actions
    @IBAction func signInButtonTapped(_ sender: Any) {
        guard let email = emailTextField.text,
              let password = passwordTextField.text else { return }
        viewModel.signIn(email: email, password: password)
    }
}
