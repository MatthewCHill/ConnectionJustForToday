//
//  SPADPost.swift
//  ConnectionJustForToday
//
//  Created by Matthew Hill on 3/30/23.
//

import Foundation

class SPADPost {
    
    enum Key {
        static let post = "post"
        static let isControversial = "controversial"
        static let uuid = "uuid"
        static let collectionType = "spadPosts"
    }
    
    let post: String
    var isControversial: Bool
    let uuid: String
    
    var dictionaryRepresentation: [String: AnyHashable] {
        
        [Key.post:self.post,
         Key.isControversial:self.isControversial,
         Key.uuid:self.uuid
        ]
    }
    
    init(post: String, isControversial: Bool = false, uuid: String = UUID().uuidString) {
        self.post = post
        self.isControversial = isControversial
        self.uuid = uuid
    }
}

extension SPADPost {
    
    convenience init? (fromDictionary dictionary: [String:Any]) {
        guard let post = dictionary[Key.post] as? String,
              let isControversial = dictionary[Key.isControversial] as? Bool,
              let uuid = dictionary[Key.uuid] as? String else {return nil}
        
        self.init(post: post, isControversial: isControversial, uuid: uuid)
    }
}
