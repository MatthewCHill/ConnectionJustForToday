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
    var jftPost: JFTPost?
    
    init(service: FirebaseService = FirebaseService(), delegate: JFTPostViewModelDelegate) {
        self.service = service
        self.delegate = delegate
    }
    
    func savePost(postBody: String, isControversial: Bool = false) {
        let jftPost = JFTPost(post: postBody)
            jftPost.post = postBody
            jftPost.isControversial = isControversial
            service.createJFTPost(post: postBody, isControversial: isControversial)
            delegate?.postSuccessfullySaved()
        
    }
    
}
