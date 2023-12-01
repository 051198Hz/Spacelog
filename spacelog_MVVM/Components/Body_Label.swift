//
//  File.swift
//  spacelog_MVVM
//
//  Created by iOS Dev on 2023/11/07.
//

import UIKit

@IBDesignable
class Body_Label: Label_TMB {
    
    override func setAttributedText() {
        super.setAttributedText()
        font = UIFont(name: Constants.Assetname.Fonts.Regular, size: font_size)
    }
    
    @IBInspectable public var font_size : CGFloat = 12
    
}
