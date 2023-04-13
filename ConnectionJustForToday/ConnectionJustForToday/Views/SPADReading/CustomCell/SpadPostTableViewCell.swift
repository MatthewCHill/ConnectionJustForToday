//
//  SpadPostTableViewCell.swift
//  ConnectionJustForToday
//
//  Created by Matthew Hill on 4/13/23.
//

import UIKit

class SpadPostTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var displayNameLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var postBodyTextView: UITextView!
    
    // MARK: - Function
    
    func updateUI(for post: SPADPost) {
        displayNameLabel.text = post.displayName
        countryLabel.text = post.country
        postBodyTextView.text = post.post
    }

}
