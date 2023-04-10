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
        spadPostTableView.dataSource = self
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
    func postsLoadedSuccessfully() {
        self.spadPostTableView.reloadData()
    }
    
    func scrapedReadingSuccessful() {
        DispatchQueue.main.async {
            self.updateUI()
        }
    }
}

extension SPADReadingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.spadPosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "spadPost", for: indexPath)
        
        return cell
    }
    
    
}
