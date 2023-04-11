//
//  User.swift
//  ConnectionJustForToday
//
//  Created by Matthew Hill on 3/30/23.
//

import Foundation

class User {
    
    enum Key {
        static let name = "name"
        static let cleanDate = "cleanDate"
        static let country = "country"
        static let uuid = "uuid"
        static let collectionType = "userInfo"
    }
    
    let name: String
    let cleanDate: Date
    let country: String
    let uuid: String
    
    var dictionaryRepresentation: [String: AnyHashable] {
        [Key.name:self.name,
         Key.cleanDate:self.cleanDate,
         Key.country:self.country,
         Key.uuid:self.uuid
        ]
    }
    
    init(name: String, cleanDate: Date, country: String, uuid: String = UUID().uuidString) {
        self.name = name
        self.cleanDate = cleanDate
        self.country = country
        self.uuid = uuid
    }
} // End of class

extension User {
    
    convenience init? (fromDictionary dictionary: [String:Any]) {
        guard let name = dictionary[Key.name] as? String,
              let cleanDate = dictionary[Key.cleanDate] as? Date,
              let country = dictionary[Key.country] as? String,
              let uuid = dictionary[Key.uuid] as? String else {return nil}
        
        self.init(name: name, cleanDate: cleanDate, country: country, uuid: uuid)
    }
}
