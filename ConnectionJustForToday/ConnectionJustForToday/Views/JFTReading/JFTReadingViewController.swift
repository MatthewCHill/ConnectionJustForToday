//
//  JFTReadingViewController.swift
//  ConnectionJustForToday
//
//  Created by Matthew Hill on 4/4/23.
//

import UIKit

class JFTReadingViewController: UIViewController{
    
    // MARK: - Outlets
    
    @IBOutlet weak var jftTitleLabel: UILabel!
    @IBOutlet weak var jftDateLabel: UILabel!
    @IBOutlet weak var jftQuoteLabel: UILabel!
    @IBOutlet weak var jftAffirmationLabel: UILabel!
    @IBOutlet weak var jftBodyTextView: UITextView!
    @IBOutlet weak var jftCopyrightLabel: UILabel!
    @IBOutlet weak var jftPostsTableView: UITableView!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = JFTReadingViewModel(delegate: self)
    }
    
    // MARK: - Properties
    var viewModel: JFTReadingViewModel!
    
    // MARK: - Functions
    
    func updateUI() {
        guard let jft = viewModel.jftReading else { return }
        jftDateLabel.text = jft.date
        jftTitleLabel.text = jft.title
        jftQuoteLabel.text = jft.reference
        jftQuoteLabel.text = jft.quote + jft.pageNumber
        jftBodyTextView.text = jft.body
        jftAffirmationLabel.text = jft.affirmation
        jftCopyrightLabel.text = jft.copyright
    }
    
    // MARK: - Actions
    
    @IBAction func shareButtonTapped(_ sender: Any) {
    }
} // End of class

// MARK: - Extensions

extension JFTReadingViewController: JFTReadingViewModelDelegate {
    func scrapedReadingSuccessful() {
        DispatchQueue.main.async {
            self.updateUI()
        }
    }
}



