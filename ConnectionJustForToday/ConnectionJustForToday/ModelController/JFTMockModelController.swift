//
//  JFTMockModelController.swift
//  ConnectionJustForToday
//
//  Created by Matthew Hill on 3/30/23.
//

import Foundation

class JFTMockModelController {
    
    static let sharedInstance = JFTMockModelController()
    var readings: [JFTReading] = []
    
    func createJFT(title: String, date: String, quote: String, body: String, aspiration: String) {
        let reading = JFTReading(date: date, title: title, quote: quote, body: body, afffirmation: aspiration)
        readings.append(reading)
    }
}
