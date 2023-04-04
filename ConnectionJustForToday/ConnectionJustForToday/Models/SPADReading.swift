//
//  SPADReading.swift
//  ConnectionJustForToday
//
//  Created by Matthew Hill on 3/30/23.
//

import Foundation

// Model Object for the Spirtual Principle a Day

class SPADReading {
    
    let date: String
    let title: String
    let quote: String
    let body: String
    let affirmation: String
    
    init(date: String, title: String, quote: String, body: String, aspiration: String) {
        self.date = date
        self.title = title
        self.quote = quote
        self.body = body
        self.affirmation = aspiration
    }
}
