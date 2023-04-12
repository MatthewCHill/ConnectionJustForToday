//
//  JFTReadingViewModel.swift
//  ConnectionJustForToday
//
//  Created by Matthew Hill on 4/4/23.
//

import Foundation

protocol JFTReadingViewModelDelegate: AnyObject {
    func scrapedReadingSuccessful()
    func postsLoadedSuccessfully()
}

class JFTReadingViewModel {
    
    // MARK: - Properties
    var jftReading: JFTReading?
    var jftPosts: [JFTPost] = []
    private var service: JFTService
    var user: CreateUserViewModel
    private var firebaseService: FirebaseService
    private weak var delegate: JFTReadingViewModelDelegate?
    
    init(service: JFTService = JFTService(), user: CreateUserViewModel = CreateUserViewModel(), firebaseService: FirebaseService = FirebaseService(), delegate: JFTReadingViewModelDelegate) {
        self.service = service
        self.user = user
        self.firebaseService = firebaseService
        self.delegate = delegate
        self.fetchJFTReading()
        self.loadPosts()
    }
    
    // MARK: - Functions
    
    func fetchJFTReading() {
        service.scrapeJFT { [weak self] result in
            switch result {
                
            case .success(let jftReading):
                self?.jftReading = jftReading
                self?.delegate?.scrapedReadingSuccessful()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func loadPosts() {
        firebaseService.loadJFTPost { [weak self] result in
            switch result {
                
            case .success(let posts):
                self?.jftPosts = posts
                self?.delegate?.postsLoadedSuccessfully()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
} // End of Class
