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
    }
    
// MARK: - Actions
    @IBAction func createUserButtonTapped(_ sender: Any) {
        guard let email = userEmailTextField.text,
              let password = userPasswordTextField.text,
              let confrimPassword = confirmPasswordTextField.text else { return }
        
        viewModel.createUser(email: email, password: password, confrimPassword: confrimPassword)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

} // End of class
