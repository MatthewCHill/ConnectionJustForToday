//
//  JFTPostCellViewModel.swift
//  ConnectionJustForToday
//
//  Created by Matthew Hill on 4/12/23.
//

import Foundation

protocol JFTPostCellViewModelDelegate: AnyObject {
    func userInfoFetched()
}

class JFTPostCellViewModel {
    
    // MARK: - Properties
    var firebaseService: FirebaseService
    var user: User?
    private weak var delegate: JFTPostCellViewModelDelegate?
    
    init(firebaseService: FirebaseService = FirebaseService(), delegate: JFTPostCellViewModelDelegate) {
        self.firebaseService = firebaseService
        self.delegate = delegate
    }
    
    func fetchUserInfo () {
        firebaseService.fetchUserInfo { [weak self] result in
            switch result {
                
            case .success(let user):
                self?.user = user
                self?.delegate?.userInfoFetched()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
