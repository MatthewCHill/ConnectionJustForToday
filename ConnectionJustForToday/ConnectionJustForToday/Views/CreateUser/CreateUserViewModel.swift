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
    
    func signIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error {
                print("Error Signing In", error.localizedDescription)
            }
            if let result {
                let user = result.user
                print(user.uid)
            }
        }
    }
    
    func signOut() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            print("Signed Out")
        } catch let signOutError as NSError {
            print("Error signing out", signOutError)
        }
    }
} // End of class
