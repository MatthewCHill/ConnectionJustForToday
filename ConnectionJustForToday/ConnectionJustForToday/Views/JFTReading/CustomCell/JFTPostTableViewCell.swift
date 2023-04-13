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
    
    // MARK: - functions
    
    func updateUI(with post: JFTPost) {
        userNameLabel.text = post.displayName
        countryLabel.text = post.country
        postBodyTextView.text = post.post
    }
}
