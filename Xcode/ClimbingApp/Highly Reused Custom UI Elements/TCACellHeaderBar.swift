//
//  TCACellHeaderBar.swift
//  ClimbingApp
//
//  Created by Matt Marks on 5/29/20.
//  Copyright © 2020 Matt Marks. All rights reserved.
//



//  Description:
//  ------------
//  A header bar used for some collection view cells.
//  Contains a title and a button with customizable options.
//  If no options are set, the button will not exist.
//
//  Options:
//  --------
//  - title: String?
//    The title on the left.
//
//  - options: [String]
//    The options avalible in the options button on the right.
//
//  - selectedOptionIndex: Int
//    The current selected option shown in the button.



import UIKit



class TCACellHeaderBar: UIControl {
    
    
    
    // MARK: Options
    
    /// The title on the left.
    public var title: String? {
        get { return titleLabel.text }
        set { titleLabel.text = newValue }
    }
    
    /// The options avalible in the options button on the right.
    public var options: [String] = []
    
    /// The current selection option shown in the button.
    public var selectedOptionIndex: Int = 0
    
    
    // MARK: Constants
    struct Constants {
        static let buttonSpacing: CGFloat = 5
        static let chevronImage: UIImage = UIImage(systemName: "chevron.down")!
    }
    

    
    // MARK: UI Element Declarations
    
    /// The horizontal stack containing the titleLabel and auxiliaryButton
    private let stack = UIStackView()
    
    /// The title that appears towards the left.
    private let titleLabel = UILabel()
    
    /// The options button that appears in the right.
    private let button = TCAButton()
    
    /// The separator at the bottom of the header bar.
    private let separator = UIView()
    
    
    
    // MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Configure titleLabel
        titleLabel.font = .preferredFont(forTextStyle: .headline, weight: .semibold)
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        // Configure button
        button.image = Constants.chevronImage
        button.imageAlignment = .right
        button.font = .preferredFont(forTextStyle: .footnote, weight: .medium)
        button.titleColor = .accent
        button.imageColor = .accent
        button.spacing = Constants.buttonSpacing
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        button.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        // Configure stack
        stack.addArrangedSubview(titleLabel)
        stack.addArrangedSubview(UIView()) // Stretches to fill the middle.
        stack.addArrangedSubview(button)
        
        stack.layoutMargins = .init(top: .cellEdgeSpacing, left: .cellEdgeSpacing, bottom: .cellEdgeSpacing, right: .cellEdgeSpacing)
        stack.insetsLayoutMarginsFromSafeArea = false
        stack.isLayoutMarginsRelativeArrangement = true
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stack)
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.leftAnchor.constraint(equalTo: leftAnchor),
            stack.rightAnchor.constraint(equalTo: rightAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        // Configure separator
        separator.backgroundColor = .divider
        separator.translatesAutoresizingMaskIntoConstraints = false
        addSubview(separator)
        NSLayoutConstraint.activate([
            separator.leftAnchor.constraint(equalTo: leftAnchor),
            separator.rightAnchor.constraint(equalTo: rightAnchor),
            separator.bottomAnchor.constraint(equalTo: bottomAnchor),
            separator.heightAnchor.constraint(equalToConstant: .dividerHeight)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // If no options are set the button is not shown.
        button.isHidden = options.isEmpty
        
        // We update the button title here instead of in init becuase we dont
        // know if options have been set then.
        updateButtonTitle()
    }
    
    
    // MARK: Button Actions
    
    /// Called when a user presses the button. An action sheet is shown to allow
    /// the user to select between the set options.
    @objc
    private func buttonPressed(sender: TCAButton) {
        
        // We create an alert.
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        // Add an action for each option.
        for (i, option) in options.enumerated() {
            let action = UIAlertAction(title: option, style: .default) { (action) in
                self.selectedOptionIndex = i
                self.updateButtonTitle()
                self.sendActions(for: .valueChanged)
            }
            alert.addAction(action)
        }

        // Add a cancel action.
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)

        // On iPad, action sheets must be presented from a popover.
        alert.popoverPresentationController?.sourceView = button

        // We can't present the action sheet on a UIControl, so we present it
        // on the current window.
        let window = UIApplication.shared.windows.filter{$0.isKeyWindow}.first
        window?.rootViewController?.present(alert, animated: true, completion: nil)

    }
    
    /// Updates the title of the button for the current options and
    /// selectedOptionIndex. If the index is out of bounds we instead default to
    /// the first option.
    private func updateButtonTitle() {
        if options.indices.contains(selectedOptionIndex) {
            button.title = options[selectedOptionIndex]
        } else {
            button.title = options.first
        }
    }

}
