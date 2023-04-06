//
//  JFTReadingViewModel.swift
//  ConnectionJustForToday
//
//  Created by Matthew Hill on 4/4/23.
//

import Foundation

protocol JFTReadingViewModelDelegate: AnyObject {
    func scrapedReadingSuccessful()
}

class JFTReadingViewModel {
    
    // MARK: - Properties
    var jftReading: JFTReading?
    private var service: JFTService
    private weak var delegate: JFTReadingViewModelDelegate?
    
    init(service: JFTService = JFTService(), delegate: JFTReadingViewModelDelegate) {
        self.service = service
        self.delegate = delegate
        self.fetchJFTReading()
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
}
