//
//  SPADPostViewController.swift
//  ConnectionJustForToday
//
//  Created by Matthew Hill on 4/10/23.
//

import UIKit

class SPADPostViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var spadBodyTextView: UITextView!
    @IBOutlet weak var displayNameTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    
    // MARK: - Propeties
    var viewModel: SPADPostViewModel!
    var spadReadingViewModel: SPADReadingViewModel?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = SPADPostViewModel(delegate: self)
    }
    
    // MARK: - functions
    
    func updateUI() {
        guard let post = spadBodyTextView.text,
        let displayName = displayNameTextField.text,
        let country = countryTextField.text else {return}
        viewModel.savePost(postBody: post, displayName: displayName, country: country)
    }
    
    // MARK: - Actions
    @IBAction func shareButtonTapped(_ sender: Any) {
        updateUI()
    }
} // End of class

// MARK: - Extensions

extension SPADPostViewController: SPADPostViewModelDelegate {
    func postSuccessfullySaved(with post: SPADPost) {
        spadReadingViewModel?.filteredSpadPosts.append(post)
        self.navigationController?.popViewController(animated: true)
    }
}
