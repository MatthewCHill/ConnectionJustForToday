//
//  JFTReading.swift
//  ConnectionJustForToday
//
//  Created by Matthew Hill on 3/30/23.
//

import Foundation

// Model Object for Just For Today Meditation Reading

class JFTReading {
    
    enum Key {
        static let date = "date"
        static let title = "title"
        static let pageNumber = "pageNumber"
        static let quote = "quote"
        static let reference = "reference"
        static let body = "body"
        static let affirmation = "affirmation"
        static let copyright = "copyright"
        static let postJFT = "postsJFT"
        static let uuid = "uuid"
    }
    
    // MARK: - Properties
    var date: String
    var title: String
    var pageNumber: String
    var quote: String
    var reference: String
    var body: String
    var affirmation: String
    var copyright: String
    var postsJFT: [JFTPost]?
    var uuid: String
    
    init(date: String = Date().stringValue(), title: String, pageNumber: String, quote: String, reference: String, body: String, affirmation: String, copyright: String, posts: [JFTPost] = [], uuid: String = UUID().uuidString) {
        
        self.date = date
        self.title = title
        self.pageNumber = pageNumber
        self.quote = quote
        self.reference = reference
        self.body = body
        self.affirmation = affirmation
        self.copyright = copyright
        self.postsJFT = posts
        self.uuid = uuid
    }
}

extension JFTReading {
    
    convenience init? (fromDictionary dictionary: [String:Any]) {
        guard let date = dictionary[Key.date] as? String,
              let title = dictionary[Key.title] as? String,
              let pageNumber = dictionary[Key.pageNumber] as? String,
              let quote = dictionary[Key.quote] as? String,
              let reference = dictionary[Key.reference] as? String,
              let body = dictionary[Key.body] as? String,
              let affirmation = dictionary[Key.affirmation] as? String,
              let copyright = dictionary[Key.copyright] as? String else { return nil }
        
        self.init(date: date, title: title, pageNumber: pageNumber, quote: quote, reference: reference, body: body, affirmation: affirmation, copyright: copyright)
    }
}


