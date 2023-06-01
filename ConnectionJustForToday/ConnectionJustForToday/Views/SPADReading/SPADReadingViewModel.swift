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
    func controversialPostDeleted()
}

class SPADReadingViewModel {
    
    // MARK: - Properties
    var spadReading: SPADReading?
    var spadPosts: [SPADPost] = []
    var filteredSpadPosts: [SPADPost] = []
    private var service: SPADService
    private var firebaseService: FirebaseService
    private weak var delegate: SpadReadingViewModelDelegate?
    
    init(service: SPADService = SPADService(), firbaseService: FirebaseService = FirebaseService(), delegate: SpadReadingViewModelDelegate) {
        self.service = service
        self.firebaseService = firbaseService
        self.delegate = delegate
        self.fetchJFTReading()
    }
    
    // MARK: - Functions
    
    func fetchJFTReading() {
        service.scrapeSPAD { [weak self] result in
            switch result {
                
            case .success(let spadReading):
                self?.spadReading = spadReading
                spadReading.date = Date().stringValue()
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
                
                for i in posts {
                    if i.date == self?.spadReading?.date {
                        self?.filteredSpadPosts.append(i)
                    }
                    self?.delegate?.postsLoadedSuccessfully()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func deletePost(post: SPADPost, completion: @escaping() -> Void) {
        guard let indexOfPost = filteredSpadPosts.firstIndex(of: post) else { return }
        firebaseService.deleteSPADPost(post: post)
        filteredSpadPosts.remove(at: indexOfPost)
        completion()
        self.delegate?.controversialPostDeleted()
        
    }
} // End Of Class
