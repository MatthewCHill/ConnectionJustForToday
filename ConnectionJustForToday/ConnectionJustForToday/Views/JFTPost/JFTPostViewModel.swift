//
//  JFTPostViewModel.swift
//  ConnectionJustForToday
//
//  Created by Matthew Hill on 4/6/23.
//

import Foundation
import FirebaseFirestore

protocol JFTPostViewModelDelegate: AnyObject {
    func postSuccessfullySaved(with post: JFTPost)
}

class JFTPostViewModel {
    
    let service: FirebaseService
    var delegate: JFTPostViewModelDelegate?
    
    init(service: FirebaseService = FirebaseService(), delegate: JFTPostViewModelDelegate) {
        self.service = service
        self.delegate = delegate
    }
    
    func savePost(postBody: String, displayName: String, country: String, isControversial: Bool = false) {
        let post = JFTPost(post: postBody, displayName: displayName, country: country, isControversial: isControversial)
            service.createJFTPost(with: post)
            delegate?.postSuccessfullySaved(with: post)
    }
}
