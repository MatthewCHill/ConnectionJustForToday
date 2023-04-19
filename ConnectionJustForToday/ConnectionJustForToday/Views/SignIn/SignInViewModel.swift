//
//  SignInViewModel.swift
//  ConnectionJustForToday
//
//  Created by Matthew Hill on 4/19/23.
//

import Foundation
import FirebaseAuth

struct SignInUserViewModel {
    
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
}
