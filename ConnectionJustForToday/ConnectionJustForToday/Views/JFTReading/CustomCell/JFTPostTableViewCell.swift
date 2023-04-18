//
//  JFTPostTableViewCell.swift
//  ConnectionJustForToday
//
//  Created by Matthew Hill on 4/12/23.
//

import UIKit

class JFTPostTableViewCell: UITableViewCell {
    // MARK: - Outlets
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var isControversialButton: UIButton!
    @IBOutlet weak var postBodyTextView: UITextView!
    
    // MARK: - properties
    
    var viewModel: JFTPostCellViewModel!
    
    
    // MARK: - functions
    
    func updateUI(with post: JFTPost) {
        userNameLabel.text = post.displayName
        countryLabel.text = post.country
        postBodyTextView.text = post.post
    }
    
    func presentControversialAlert() {
        let alertController = UIAlertController(title: "Controversial Comment", message: "Selecting done will flag the post to be deleted.", preferredStyle: .alert)
        
        let dismissAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        let confirmAction = UIAlertAction(title: "Report", style: .default)
        
        alertController.addAction(dismissAction)
        alertController.addAction(confirmAction)
    }
    
    // MARK: - Actions
    @IBAction func isControversialButtonTapped(_ sender: Any) {
        presentControversialAlert()
    }
    
} // End of class

// MARK: - Extensions

extension JFTPostTableViewCell: JFTPostCellViewModelDelegate {
    func postDeleted() {
    }
}
