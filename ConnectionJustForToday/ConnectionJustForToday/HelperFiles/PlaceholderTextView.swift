//
//  PlaceholderTextView.swift
//  ConnectionJustForToday
//
//  Created by Matthew Hill on 4/20/23.
//

import UIKit

class PlaceHolderTextView: UITextView {
    // MARK: - Properties
    private let placeholderLabel = UILabel()
    var placeholder: String = "Share your Experience Strength And Hope..." {
        didSet {
            placeholderLabel.text = placeholder
        }
    }
    var placeholderColor: UIColor = .gray {
        didSet {
            placeholderLabel.textColor = placeholderColor
        }
    }
    
    // MARK: - Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        delegate = self

        placeholderLabel.text = placeholder
        placeholderLabel.textColor = placeholderColor
        placeholderLabel.font = self.font
        placeholderLabel.numberOfLines = 0
        addSubview(placeholderLabel)
    }
    
    // MARK: - Functions
    override func layoutSubviews() {
        super.layoutSubviews()
        
        placeholderLabel.frame = CGRect(x: textContainerInset.left + textContainer.lineFragmentPadding,
                                        y: textContainerInset.top,
                                        width: bounds.width - textContainerInset.left - textContainerInset.right - textContainer.lineFragmentPadding * 2,
                                        height: bounds.height - textContainerInset.top - textContainerInset.bottom)
        placeholderLabel.sizeToFit()
    }
    
    private func updatePlaceholder() {
        placeholderLabel.isHidden = !text.isEmpty
    }
} // End of class

extension PlaceHolderTextView: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        updatePlaceholder()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        placeholderLabel.isHidden = true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        updatePlaceholder()
    }
}
