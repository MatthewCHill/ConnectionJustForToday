//
//  SPADPost.swift
//  ConnectionJustForToday
//
//  Created by Matthew Hill on 3/30/23.
//

import Foundation

class SPADPost {
    
    let post: String
    var isControversial: Bool
    let uuid: String
    
    init(post: String, isControversial: Bool = false, uuid: String = UUID().uuidString) {
        self.post = post
        self.isControversial = isControversial
        self.uuid = uuid
    }

}
