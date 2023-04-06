//
//  SPADReadingViewController.swift
//  ConnectionJustForToday
//
//  Created by Matthew Hill on 4/4/23.
//

import UIKit

class SPADReadingViewController: UIViewController{
    
    // MARK: - Outlets
    @IBOutlet weak var spadTitleLabel: UILabel!
    @IBOutlet weak var spadDateLabel: UILabel!
    @IBOutlet weak var spadQuoteLabel: UILabel!
    @IBOutlet weak var spadBodyTextView: UITextView!
    @IBOutlet weak var spadAffirmationLabel: UILabel!
    @IBOutlet weak var spadCopyrightLabel: UILabel!
    @IBOutlet weak var spadPostTableView: UITableView!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = SPADReadingViewModel(delegate: self)
    }
    
    // MARK: - Properties
    var viewModel: SPADReadingViewModel!
    
    // MARK: - Functions
    
    func updateUI() {
        guard let spad = viewModel.spadReading else { return }
        spadTitleLabel.text = spad.title
        spadDateLabel.text = spad.date
        spadQuoteLabel.text = spad.quote
        spadBodyTextView.text = spad.body
        spadAffirmationLabel.text = spad.affirmation
        spadCopyrightLabel.text = spad.copyright
    }
} // End of class

// MARK: - Extension

extension SPADReadingViewController: SpadReadingViewModelDelegate {
    func scrapedReadingSuccessful() {
        DispatchQueue.main.async {
            self.updateUI()
        }
    }
}
