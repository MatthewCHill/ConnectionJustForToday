//
//  JFTReadingViewController.swift
//  ConnectionJustForToday
//
//  Created by Matthew Hill on 4/4/23.
//

import UIKit
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore

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
        jftPostsTableView.dataSource = self
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
    @IBAction func signOutButtonTapped(_ sender: Any) {
        viewModel.user.signOut()
        navigationController?.popViewController(animated: true)
    }
} // End of class

// MARK: - Extensions

extension JFTReadingViewController: JFTReadingViewModelDelegate {
    func postsLoadedSuccessfully() {
        self.jftPostsTableView.reloadData()
    }
    
    func scrapedReadingSuccessful() {
        DispatchQueue.main.async {
            self.updateUI()
        }
    }
}

extension JFTReadingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.jftPosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "jftPost", for: indexPath)
        
        return cell
    }
}




