//
//  SPADReadingViewModel.swift
//  ConnectionJustForToday
//
//  Created by Matthew Hill on 4/4/23.
//

import Foundation

protocol SpadReadingViewModelDelegate: AnyObject {
    func scrapedReadingSuccessful()
    func postsLoadedSuccessfully()
}

class SPADReadingViewModel {
    
    // MARK: - Properties
    var spadReading: SPADReading?
    var spadPosts: [SPADPost] = []
    private var service: SPADService
    private var firebaseService: FirebaseService
    private weak var delegate: SpadReadingViewModelDelegate?
    
    init(service: SPADService = SPADService(), firbaseService: FirebaseService = FirebaseService(), delegate: SpadReadingViewModelDelegate) {
        self.service = service
        self.firebaseService = firbaseService
        self.delegate = delegate
        self.fetchJFTReading()
        self.fetchPosts()
    }
    
    // MARK: - Functions
    
    func fetchJFTReading() {
        service.scrapeSPAD { [weak self] result in
            switch result {
                
            case .success(let spadReading):
                self?.spadReading = spadReading
                self?.delegate?.scrapedReadingSuccessful()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchPosts() {
        firebaseService.loadSPADPost { [weak self] result in
            switch result {
                
            case .success(let posts):
                self?.spadPosts = posts
                self?.delegate?.postsLoadedSuccessfully()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
} // End Of Class
