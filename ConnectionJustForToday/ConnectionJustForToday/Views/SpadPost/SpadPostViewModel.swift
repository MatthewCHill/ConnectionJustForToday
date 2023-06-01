//
//  SpadPostViewModel.swift
//  ConnectionJustForToday
//
//  Created by Matthew Hill on 4/10/23.
//

import Foundation
import FirebaseFirestore

protocol SPADPostViewModelDelegate: AnyObject {
    func postSuccessfullySaved(with post: SPADPost)
}

class SPADPostViewModel {
    
    let service: FirebaseService
    var delegate: SPADPostViewModelDelegate?
    var spadPost: SPADPost?
    
    init(service: FirebaseService = FirebaseService(), delegate: SPADPostViewModelDelegate) {
        self.service = service
        self.delegate = delegate
    }
    
    func savePost(postBody: String, displayName: String, country: String, isControversial: Bool = false) {
        let post = SPADPost(post: postBody, displayName: displayName, country: country, isControversial: isControversial)
        service.createSPADPost(with: post)
        delegate?.postSuccessfullySaved(with: post)
    }
} // End of class
