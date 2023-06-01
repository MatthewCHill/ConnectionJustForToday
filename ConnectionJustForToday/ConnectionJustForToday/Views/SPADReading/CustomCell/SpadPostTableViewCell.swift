//
//  SpadPostTableViewCell.swift
//  ConnectionJustForToday
//
//  Created by Matthew Hill on 4/13/23.
//

import UIKit

protocol SpadPostTableViewCellDelegate: AnyObject {
    func presentAlert(with post: SPADPost)
}

class SpadPostTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var displayNameLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var postBodyTextView: UITextView!
    
    // MARK: - Properties
    var spadPost: SPADPost?
    var delegate: SpadPostTableViewCellDelegate?
    
    // MARK: - Function
    
    func updateUI(for post: SPADPost) {
        displayNameLabel.text = post.displayName
        countryLabel.text = post.country
        postBodyTextView.text = post.post
    }
    
    // MARK: - Actions
    @IBAction func controversialButtonTapped(_ sender: Any) {
        guard let spadPost = spadPost else { return }
        delegate?.presentAlert(with: spadPost)
    }
} // End of class
