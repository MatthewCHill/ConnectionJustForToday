//
//  User.swift
//  ConnectionJustForToday
//
//  Created by Matthew Hill on 3/30/23.
//

import Foundation

class User {
    
    let name: String
    let cleanDate: Date
    let country: String
    
    init(name: String, cleanDate: Date, country: String) {
        self.name = name
        self.cleanDate = cleanDate
        self.country = country
    }
}
