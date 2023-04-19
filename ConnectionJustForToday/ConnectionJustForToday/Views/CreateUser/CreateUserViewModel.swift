//
//  CreateUserViewModel.swift
//  ConnectionJustForToday
//
//  Created by Matthew Hill on 4/4/23.
//

import Foundation
import FirebaseAuth

struct CreateUserViewModel {
    
    func createUser(email: String, password: String, confrimPassword: String) {
        if password == confrimPassword {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let error {
                    print("Error Creating User", error.localizedDescription)
                }
                if let authResult {
                    let user = authResult.user
                    print(user.uid)
                }
            }
        } else {
            print("Password Dont Match")
        }
    }
} // End of class
