//
//  SPADReadingViewModel.swift
//  ConnectionJustForToday
//
//  Created by Matthew Hill on 4/4/23.
//

import Foundation

protocol SpadReadingViewModelDelegate: AnyObject {
    func scrapedReadingSuccessful()
}

class SPADReadingViewModel {
    
    // MARK: - Properties
    var spadReading: SPADReading?
    private var service: SPADService
    private weak var delegate: SpadReadingViewModelDelegate?
    
    init(service: SPADService = SPADService(), delegate: SpadReadingViewModelDelegate) {
        self.service = service
        self.delegate = delegate
        self.fetchJFTReading()
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
}
