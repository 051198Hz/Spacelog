//
//  File.swift
//  spacelog_MVVM
//
//  Created by iOS Dev on 2023/11/07.
//

import UIKit

@IBDesignable
class Heading_Label: Label_TMB {
    
    override func setAttributedText() {
        super.setAttributedText()
        font = UIFont(name: "GowunBatang-Bold", size: font_size)

    }
    
    @IBInspectable public var font_size : CGFloat = 18
    
}
