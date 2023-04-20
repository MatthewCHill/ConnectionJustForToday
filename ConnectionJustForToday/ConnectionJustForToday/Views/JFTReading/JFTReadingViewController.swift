//
//  JFTReadingViewController.swift
//  ConnectionJustForToday
//
//  Created by Matthew Hill on 4/4/23.
//

import UIKit

class JFTReadingViewController: UIViewController{
    
    // MARK: - Outlets
    @IBOutlet weak var jftDateLabel: UILabel!
    @IBOutlet weak var jftQuoteLabel: UILabel!
    @IBOutlet weak var jftAffirmationLabel: UILabel!
    @IBOutlet weak var jftBodyTextView: UITextView!
    @IBOutlet weak var jftCopyrightLabel: UILabel!
    @IBOutlet weak var jftPostsTableView: UITableView!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpActivityIndicator()
        viewModel = JFTReadingViewModel(delegate: self)
        jftPostsTableView.dataSource = self
        viewModel.loadPosts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        jftPostsTableView.reloadData()
    }

    // MARK: - Properties
    var viewModel: JFTReadingViewModel!
    let activityIndicator = UIActivityIndicatorView()
    
    // MARK: - Functions 
    
    func updateUI() {
        guard let jft = viewModel.jftReading else { return }
        jftDateLabel.text = jft.date
        navigationItem.title = jft.title
        jftQuoteLabel.text = "\(jft.quote) \(jft.reference)"
        jftBodyTextView.text = jft.body
        jftAffirmationLabel.text = jft.affirmation
        jftCopyrightLabel.text = jft.copyright
    }
    
    func presentControversialAlert(post: JFTPost) {
        let alertController = UIAlertController(title: "Controversial Comment", message: "Selecting report will flag the post to be deleted.", preferredStyle: .alert)
        
        let dismissAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        let confirmAction = UIAlertAction(title: "Report", style: .default) { _ in
            self.viewModel.deletePost(post: post) {
                self.dismiss(animated: true)
            }
        }
        
        alertController.addAction(dismissAction)
        alertController.addAction(confirmAction)
        present(alertController, animated: true)
    }
    
    func setUpActivityIndicator() {
        self.view.addSubview(activityIndicator)
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large
        self.view.isUserInteractionEnabled = false
        activityIndicator.startAnimating()
        self.view.isHidden = true
    }
    
    func stopAnimating() {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
        self.view.isUserInteractionEnabled = true
        self.view.isHidden = false
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "jftPost",
              let destinationVC = segue.destination as? JFTPostViewController else {return}
        destinationVC.jftReadingViewModel = viewModel
    }
} // End of class

// MARK: - Extensions
extension JFTReadingViewController: JFTReadingViewModelDelegate {
    func controversialPostDeleted() {
        self.jftPostsTableView.reloadData()
    }
    
    func postsLoadedSuccessfully() {
        self.jftPostsTableView.reloadData()
    }
    
    func scrapedReadingSuccessful() {
        DispatchQueue.main.async {
            self.updateUI()
            self.viewModel.loadPosts()
            self.stopAnimating()
        }
    }
}

extension JFTReadingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredJFTPosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "jftPost", for: indexPath) as? JFTPostTableViewCell else {return UITableViewCell()}
        
        let post = viewModel.filteredJFTPosts[indexPath.row]
        cell.updateUI(with: post)
        cell.jftPost = post
        cell.delegate = self
        
        return cell
    }
}

extension JFTReadingViewController: JFTPostTableViewCellDelegate {
    func presentAlert(with post: JFTPost) {
        presentControversialAlert(post: post)
    }
}
