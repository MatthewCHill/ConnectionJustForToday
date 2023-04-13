//
//  JFTPostViewModel.swift
//  ConnectionJustForToday
//
//  Created by Matthew Hill on 4/6/23.
//

import Foundation
import FirebaseFirestore

protocol JFTPostViewModelDelegate: AnyObject {
    func postSuccessfullySaved()
}

class JFTPostViewModel {
    
    let service: FirebaseService
    var delegate: JFTPostViewModelDelegate?
    var jftPosts: JFTPost?
    
    init(service: FirebaseService = FirebaseService(), delegate: JFTPostViewModelDelegate) {
        self.service = service
        self.delegate = delegate
    }
    
    func savePost(postBody: String, displayName: String, country: String, isControversial: Bool = false) {
            service.createJFTPost(post: postBody, displayName: displayName, country: country, isControversial: isControversial)
            delegate?.postSuccessfullySaved()
    }
}
