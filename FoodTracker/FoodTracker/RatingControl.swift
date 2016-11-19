//
//  RatingControl.swift
//  FoodTracker
//
//  Created by Fei Zheng on 11/19/16.
//  Copyright © 2016 Fei Zheng. All rights reserved.
//

import UIKit

class RatingControl: UIView {

    // MARK: Properties
    
    var rating = 0 {
        didSet {
            setNeedsLayout()
        }
    }
    var ratingButtons = [UIButton]()
    let spacing = 5
    let starCount = 5
    let length = 44
    
    // MARK: Initialization
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let filledStarImage = UIImage(named: "filledStar")
        let emptyStarImage = UIImage(named: "emptyStar")
        
        
        
        for _ in 0 ..< starCount {
            let button = UIButton(frame: CGRect(x: 0, y: 0, width: length, height: length))
            
            button.setImage(emptyStarImage, for: .normal)
            button.setImage(filledStarImage, for: .selected)
            button.setImage(filledStarImage, for: [.highlighted, .selected])
            
            
            button.adjustsImageWhenHighlighted = false
            
            addSubview(button)
        
            ratingButtons += [button]
            button.addTarget(self, action: #selector(ratingButtonTapped), for: .touchDown)
        }
    }
    
    override func layoutSubviews() {
        // Set the button's width and height to a square the size of the frame's height.
        var buttonFrame = CGRect(x: 0, y: 0, width: length, height: length)
        
        // Offset each button's origin by the length of the button plus some spacing.
        for (index, button) in ratingButtons.enumerated() {
            buttonFrame.origin.x = CGFloat(index * (length + spacing))
            button.frame = buttonFrame
        }
        updateButtonSelectionStates()
    }
    
    override public var intrinsicContentSize: CGSize {
        let width = (length * starCount) + (spacing * (starCount - 1))
        
        return CGSize(width: width, height: length)
    }

    // MARK: Button Action
    
    func ratingButtonTapped(button: UIButton) {
        print("Button pressed 👍")
        rating = ratingButtons.index(of: button)! + 1
        
        
        updateButtonSelectionStates()
    }
    func updateButtonSelectionStates() {
        
        for (index, button) in ratingButtons.enumerated() {
            // If the index of a button is less than the rating, that button should be selected.
            button.isSelected = index < rating
        }
    }
    
}
