//
//  JFTPostTableViewCell.swift
//  ConnectionJustForToday
//
//  Created by Matthew Hill on 4/12/23.
//

import UIKit

protocol JFTPostTableViewCellDelegate: AnyObject {
    func presentAlert(with post: JFTPost)
}

class JFTPostTableViewCell: UITableViewCell {
    // MARK: - Outlets
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var isControversialButton: UIButton!
    @IBOutlet weak var postBodyTextView: UITextView!
    
    // MARK: - properties
    var jftPost: JFTPost?
    var delegate: JFTPostTableViewCellDelegate?

    // MARK: - functions
    
    func updateUI(with post: JFTPost) {
        userNameLabel.text = post.displayName
        countryLabel.text = post.country
        postBodyTextView.text = post.post
    }
    
    // MARK: - Actions
    @IBAction func isControversialButtonTapped(_ sender: Any) {
        guard let jftPost = jftPost else { return }
        delegate?.presentAlert(with: jftPost)
    }
    
} // End of class

