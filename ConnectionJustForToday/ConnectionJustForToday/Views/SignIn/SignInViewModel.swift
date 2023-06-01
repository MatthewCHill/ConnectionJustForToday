//
//  SignInViewModel.swift
//  ConnectionJustForToday
//
//  Created by Matthew Hill on 4/19/23.
//

import Foundation
import FirebaseAuth

protocol SignInUserViewModelDelegate: AnyObject {
    func signInSuccessfull()
}

struct SignInUserViewModel {
    
    // MARK: - Properties
    var delegate: SignInUserViewModelDelegate?
    
    init(delegate: SignInUserViewModelDelegate) {
        self.delegate = delegate
    }
    
    func signIn(email: String, password: String, completion: @escaping (Bool, Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error {
                print("Error Signing In", error.localizedDescription)
                completion(false, error)
            }
            
            if let authResult {
                let user = authResult.user
                print(user.uid)
                completion(true, nil)
            }
        }
    }
}
