//
//  SignInViewController.swift
//  ConnectionJustForToday
//
//  Created by Matthew Hill on 4/19/23.
//

import UIKit
import AuthenticationServices

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
        let signInWithApple = ASAuthorizationAppleIDButton()
        signInWithApple.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(signInWithApple)
        NSLayoutConstraint.activate([
            signInWithApple.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            signInWithApple.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50),
            signInWithApple.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -70),
            signInWithApple.heightAnchor.constraint(equalToConstant: 50)
        ])
        signInWithApple.addTarget(self, action: #selector(appleSignInButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Functions
    
    @objc func appleSignInButtonTapped() {
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [
            .email
        ]
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.presentationContextProvider = self
        authorizationController.delegate = self
        authorizationController.performRequests()
    }
    
    
    // MARK: - Actions
    @IBAction func signInButtonTapped(_ sender: Any) {
        guard let email = emailTextField.text,
              let password = passwordTextField.text else { return }
        viewModel.signIn(email: email, password: password)
    }
} // End of class

// MARK: - Extensions

extension SignInViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}
extension SignInViewController: ASAuthorizationControllerDelegate {
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        <#code#>
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        <#code#>
    }
}
