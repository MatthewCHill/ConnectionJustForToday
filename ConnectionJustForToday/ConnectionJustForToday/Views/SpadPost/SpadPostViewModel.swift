//
//  SpadPostViewModel.swift
//  ConnectionJustForToday
//
//  Created by Matthew Hill on 4/10/23.
//

import Foundation
import FirebaseFirestore

protocol SPADPostViewModelDelegate: AnyObject {
    func postSuccessfullySaved()
}

class SPADPostViewModel {
    
    let service: FirebaseService
    var delegate: SPADPostViewModelDelegate?
    var spadPost: SPADPost?
    
    init(service: FirebaseService = FirebaseService(), delegate: SPADPostViewModelDelegate) {
        self.service = service
        self.delegate = delegate
    }
    
    func savePost(postBody: String, isControversial: Bool = false) {
        let spadPost = SPADPost(post: postBody)
        spadPost.post = postBody
        spadPost.isControversial = isControversial
        service.createSPADPost(post: postBody, isControversial: isControversial)
        delegate?.postSuccessfullySaved()
    }
} // End of class
