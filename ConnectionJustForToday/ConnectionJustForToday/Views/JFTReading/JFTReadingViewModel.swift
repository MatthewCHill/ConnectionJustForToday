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
    func controversialPostDeleted()
}

class JFTReadingViewModel {
    
    // MARK: - Properties
    var jftReading: JFTReading?
    var jftPosts: [JFTPost] = []
    var filteredJFTPosts: [JFTPost] = []
    private var service: JFTService
    private var firebaseService: FirebaseService
    private weak var delegate: JFTReadingViewModelDelegate?
    
    init(service: JFTService = JFTService(), firebaseService: FirebaseService = FirebaseService(), delegate: JFTReadingViewModelDelegate) {
        self.service = service
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
                jftReading.date = Date().stringValue()
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
                
                for i in posts {
                    if i.date == self?.jftReading?.date {
                        self?.filteredJFTPosts.append(i)
                    }
                    self?.delegate?.postsLoadedSuccessfully()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func deletePost(post: JFTPost, completion: @escaping() -> Void) {
        guard let indexOfPost = filteredJFTPosts.firstIndex(of: post) else { return }
        firebaseService.deleteJFTPost(post: post)
        filteredJFTPosts.remove(at: indexOfPost)
        completion()
        self.delegate?.controversialPostDeleted()
    }
} // End of Class
