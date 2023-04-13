//
//  JFTPostViewController.swift
//  ConnectionJustForToday
//
//  Created by Matthew Hill on 4/6/23.
//

import UIKit

class JFTPostViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var jftPostTextView: UITextView!
    @IBOutlet weak var displayNameTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    
    // MARK: - Propeties
    var viewModel: JFTPostViewModel!
    
// MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = JFTPostViewModel(delegate: self)
    }
    
    // MARK: - Functions
    func updateUI() {
        guard let post = jftPostTextView.text,
        let displayName = displayNameTextField.text,
        let country = countryTextField.text else {return}
        viewModel.savePost(postBody: post, displayName: displayName, country: country)
    }
    
    // MARK: - Actions
    @IBAction func shareButtonTapped(_ sender: Any) {
        updateUI()
    }
}

// MARK: - Extensions

extension JFTPostViewController: JFTPostViewModelDelegate {
    func postSuccessfullySaved() {
        self.navigationController?.popViewController(animated: true)
    }
}
    
