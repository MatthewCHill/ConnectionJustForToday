//
//  JFTReading.swift
//  ConnectionJustForToday
//
//  Created by Matthew Hill on 3/30/23.
//

import Foundation

// Model Object for Just For Today Meditation Reading

class JFTReading {
    
    
    // MARK: - Properties
    var date: String
    var title: String
    var quote: String
    var body: String
    var afffirmation: String
    var postsJFT: [JFTPost]
    var uuid: String
    
    init(date: String, title: String, quote: String, body: String, afffirmation: String, posts: [JFTPost], uuid: String) {
        self.date = date
        self.title = title
        self.quote = quote
        self.body = body
        self.afffirmation = afffirmation
        self.postsJFT = posts
        self.uuid = uuid
    }
}


