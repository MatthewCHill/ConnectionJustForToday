//
//  DateExtension.swift
//  ConnectionJustForToday
//
//  Created by Matthew Hill on 4/17/23.
//

import Foundation

extension Date {
    
    func stringValue() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter.string(from: self)
    }
}
