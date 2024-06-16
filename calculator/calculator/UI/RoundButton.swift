//
//  RoundButton.swift
//  calculator
//
//  Created by Jaehwi Kim on 2024/01/13.
//

import UIKit

@IBDesignable
class RoundButton: UIButton {
    @IBInspectable var isCircular: Bool = true
    private var aspectRatioConstraint: NSLayoutConstraint?
    
    // CGLayer는 Autolayout에 영향을 안받음, layoutSubview에 넣어 bounds가 바뀔때 set
    override func layoutSubviews() {
        super.layoutSubviews()
        if isCircular {
            setCircular()
        }
        self.layer.cornerRadius = self.frame.height * 0.5
        self.clipsToBounds = true
    }
    
    private func setCircular() {
        // Remove existing aspect ratio constraint if any
        aspectRatioConstraint?.isActive = false
        
        // Create a new aspect ratio constraint (1:1)
        aspectRatioConstraint = NSLayoutConstraint(
            item: self,
            attribute: .width,
            relatedBy: .equal,
            toItem: self,
            attribute: .height,
            multiplier: 1.0,
            constant: 0
        )
        
        // Activate the constraint
        aspectRatioConstraint?.isActive = true
    }
}
