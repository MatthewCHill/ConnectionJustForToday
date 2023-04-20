//
//  UserSettingViewModel.swift
//  ConnectionJustForToday
//
//  Created by Matthew Hill on 4/4/23.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

protocol UserSettingViewModelDelegate: AnyObject {
    func userSettingsSaved()
    func userSettingsFetched(with user: User)
}

class UserSettingViewModel {
    
    // MARK: - Properties
    let service: FirebaseService
    var delegate: UserSettingViewModelDelegate?
    var user: User?
    var users: [User] = []
    
    init(service: FirebaseService = FirebaseService(), delegate: UserSettingViewModelDelegate) {
        self.service = service
        self.delegate = delegate
        self.fetchUserInfo()
    }
    
    func saveUserSettings(userName: String, userCountry: String, cleanDate: String) {
        guard let userUUID = Auth.auth().currentUser?.uid else { return }
        let user = User(name: userName, cleanDate: cleanDate, country: userCountry, uuid: userUUID)
        user.name = userName
        user.cleanDate = cleanDate
        user.country = userCountry
        service.saveUserSetting(userName: userName, cleanDate: cleanDate, country: userCountry)
        delegate?.userSettingsSaved()
    }
    
    func signOut() {
        service.signOut()
    }
    
    func fetchUserInfo() {
        service.fetchUserInfo { [weak self] result in
            switch result {
                
            case .success(let users):
                self?.users = users
                for i in users {
                    if Auth.auth().currentUser?.uid == i.uuid {
                        self?.users.append(i)
                        let user = i 
                        self?.delegate?.userSettingsFetched(with: user)
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
} // End of class
