//
//  UserSettingViewModel.swift
//  ConnectionJustForToday
//
//  Created by Matthew Hill on 4/4/23.
//

import Foundation
import FirebaseFirestore

protocol UserSettingViewModelDelegate: AnyObject {
    func userSettingsSaved()
}

class UserSettingViewModel {
    
    // MARK: - Properties
    let service: FirebaseService
    var delegate: UserSettingViewModelDelegate?
    var user: User?
    
    init(service: FirebaseService = FirebaseService(), delegate: UserSettingViewModelDelegate) {
        self.service = service
        self.delegate = delegate
    }
    
    func saveUserSettings(userName: String, userCountry: String, cleandDate: String) {
        let user = User(name: userName, cleanDate: cleandDate, country: userCountry)
        user.name = userName
        user.cleanDate = cleandDate
        user.country = userCountry
        service.saveUserSetting(userName: userName, cleanDate: cleandDate, country: userCountry)
        delegate?.userSettingsSaved()
    }
} // End of class
