//
//  JFTPostCellViewModel.swift
//  ConnectionJustForToday
//
//  Created by Matthew Hill on 4/17/23.
//

import Foundation

protocol JFTPostCellViewModelDelegate: AnyObject {
    func postDeleted()
}

class JFTPostCellViewModel {
    
    // MARK: - Properties
    private var firebaseService: FirebaseService
    private var delegate: JFTPostCellViewModelDelegate?
    
    init(firebaseService: FirebaseService = FirebaseService(), delegate: JFTPostCellViewModelDelegate) {
        self.firebaseService = firebaseService
        self.delegate = delegate
    }
    
    // MARK: - Functions
    
    func deletePost(with jftPost: JFTPost) {
        firebaseService.deleteJFTPost(post: jftPost)
        delegate?.postDeleted()
    }
}
