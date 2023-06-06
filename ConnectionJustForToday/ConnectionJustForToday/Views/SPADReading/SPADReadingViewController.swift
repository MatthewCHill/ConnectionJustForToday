//
//  SPADReadingViewController.swift
//  ConnectionJustForToday
//
//  Created by Matthew Hill on 4/4/23.
//

import UIKit

class SPADReadingViewController: UIViewController{
    
    // MARK: - Outlets
    @IBOutlet weak var spadDateLabel: UILabel!
    @IBOutlet weak var spadQuoteLabel: UILabel!
    @IBOutlet weak var spadBodyTextView: UITextView!
    @IBOutlet weak var spadAffirmationLabel: UILabel!
    @IBOutlet weak var spadCopyrightLabel: UILabel!
    @IBOutlet weak var spadPostTableView: UITableView!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpActivityIndicator()
        viewModel = SPADReadingViewModel(delegate: self)
        spadPostTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.fetchPosts()
        self.spadPostTableView.reloadData()
    }
    
    // MARK: - Properties
    var viewModel: SPADReadingViewModel!
    let activityIndicator = UIActivityIndicatorView()
    
    // MARK: - Functions
    
    func updateUI() {
        guard let spad = viewModel.spadReading else { return }
        navigationItem.title = spad.title
        spadDateLabel.text = spad.date
        spadQuoteLabel.text = spad.quote
        spadBodyTextView.text = spad.body
        spadAffirmationLabel.text = "Just For Today: \(spad.affirmation)"
        spadCopyrightLabel.text = spad.copyright
    }
    
    func presentControversialAlert(post: SPADPost) {
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
        guard segue.identifier == "spadPost",
              let destinationVC = segue.destination as? SPADPostViewController else { return }
        destinationVC.spadReadingViewModel = viewModel
    }
} // End of class

// MARK: - Extension
extension SPADReadingViewController: SpadReadingViewModelDelegate {
    func controversialPostDeleted() {
        self.spadPostTableView.reloadData()
    }
    
    func postsLoadedSuccessfully() {
        self.spadPostTableView.reloadData()
    }
    
    func scrapedReadingSuccessful() {
        DispatchQueue.main.async {
            self.updateUI()
            self.viewModel.fetchPosts()
            self.stopAnimating()
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
        cell.spadPost = post
        cell.delegate = self
        
        return cell
    }
}

extension SPADReadingViewController: SpadPostTableViewCellDelegate {
    func presentAlert(with post: SPADPost) {
        presentControversialAlert(post: post)
    }
}
