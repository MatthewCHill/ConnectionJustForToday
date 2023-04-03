//
//  TestingMockDataViewController.swift
//  ConnectionJustForToday
//
//  Created by Matthew Hill on 3/30/23.
//

import UIKit

class TestingMockDataViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var bodyTextView: UITextView!
    @IBOutlet weak var affirmationLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    func updateViews() {
        let reading = JFTMockModelController.sharedInstance.readings[0]
        titleLabel.text = reading.title
        dateLabel.text = reading.date
        quoteLabel.text = reading.quote
        bodyTextView.text = reading.body
        affirmationLabel.text = reading.afffirmation
    }
    
}
