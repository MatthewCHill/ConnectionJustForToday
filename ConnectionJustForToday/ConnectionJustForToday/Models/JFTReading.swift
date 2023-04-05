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
    var pageNumber: String
    var quote: String
    var reference: String
    var body: String
    var afffirmation: String
    var copyright: String
    var postsJFT: [JFTPost]?
    var uuid: String
    
    init(date: String, title: String, pageNumber: String, quote: String, reference: String, body: String, afffirmation: String, copyright: String, posts: [JFTPost] = [], uuid: String = UUID().uuidString) {
        
        self.date = date
        self.title = title
        self.pageNumber = pageNumber
        self.quote = quote
        self.reference = reference
        self.body = body
        self.afffirmation = afffirmation
        self.copyright = copyright
        self.postsJFT = posts
        self.uuid = uuid
    }
}


