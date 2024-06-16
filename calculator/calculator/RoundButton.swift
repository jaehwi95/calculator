//
//  RoundButton.swift
//  calculator
//
//  Created by Jaehwi Kim on 2023/12/27.
//

import UIKit

@IBDesignable
class RoundButton: UIButton {
    @IBInspectable var isRound: Bool = true {
        didSet {
            if isRound {
                self.layer.cornerRadius = self.frame.height * 0.5
                self.clipsToBounds = true
            }
        }
    }
    
    // CGLayer는 Autolayout에 영향을 안받음, layoutSubview에 넣어 bounds가 바뀔때 set
    override func layoutSubviews() {
        super.layoutSubviews()
        if isRound {
            self.layer.cornerRadius = self.frame.height * 0.5
            self.clipsToBounds = true
        }
    }
}
