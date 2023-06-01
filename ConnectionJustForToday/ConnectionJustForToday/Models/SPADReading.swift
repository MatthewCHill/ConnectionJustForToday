//
//  SPADReading.swift
//  ConnectionJustForToday
//
//  Created by Matthew Hill on 3/30/23.
//

import Foundation

// Model Object for the Spirtual Principle a Day

class SPADReading {
    
    enum Key {
        static let date = "date"
        static let title = "title"
        static let pageNumber = "pageNumber"
        static let quote = "quote"
        static let reference = "reference"
        static let body = "body"
        static let affirmation = "affirmation"
        static let copryright = "copyright"
        static let uuid = "uuid"
        static let spadPosts = "spadPosts"
    }
    
    var date: String
    let title: String
    let pageNumber: String
    let quote: String
    let reference: String
    let body: String
    let affirmation: String
    let copyright: String
    let uuid: String
    let spadPosts: [SPADPost]
    
    init(date: String, title: String, pageNumber: String, quote: String, reference: String, body: String, affirmation: String, copyright: String, uuid: String = UUID().uuidString, spadPosts: [SPADPost] = []) {
        self.date = date
        self.title = title
        self.pageNumber = pageNumber
        self.quote = quote
        self.reference = reference
        self.body = body
        self.affirmation = affirmation
        self.copyright = copyright
        self.uuid = uuid
        self.spadPosts = spadPosts
    }
}

extension SPADReading {
    
    convenience init? (fromDictionary dictionary: [String:Any]) {
        guard let date = dictionary[Key.date] as? String,
              let title = dictionary[Key.title] as? String,
              let pageNumber = dictionary[Key.pageNumber] as? String,
              let quote = dictionary[Key.quote] as? String,
              let reference = dictionary[Key.reference] as? String,
              let body = dictionary[Key.body] as? String,
              let affirmation = dictionary[Key.affirmation] as? String,
              let copyright = dictionary[Key.copryright] as? String else { return nil }
        
        self.init(date: date, title: title, pageNumber: pageNumber, quote: quote, reference: reference, body: body, affirmation: affirmation, copyright: copyright)
    }
}
