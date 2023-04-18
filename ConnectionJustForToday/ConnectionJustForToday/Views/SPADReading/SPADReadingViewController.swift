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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchPosts()
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
        spadAffirmationLabel.text = "Just For Today: \(spad.affirmation)"
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
            self.viewModel.fetchPosts()
        }
    }
}

extension SPADReadingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredSpadPosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "spadPost", for: indexPath) as? SpadPostTableViewCell else {return UITableViewCell()}
        
        let post = viewModel.filteredSpadPosts[indexPath.row]
        cell.updateUI(for: post)
        return cell
    }
}
