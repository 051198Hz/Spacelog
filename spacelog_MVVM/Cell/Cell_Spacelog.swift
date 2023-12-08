//
//  Cell_Spacelog.swift
//  spacelog_MVVM
//
//  Created by iOS Dev on 2023/12/08.
//

import UIKit

class Cell_Spacelog: UICollectionViewCell {
    
    @IBOutlet weak var box_date: UIView!
    @IBOutlet weak var label_date: Body_Label!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textView: TextView_TMB!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textView.isEditable = false
        textView.setUI()
        textView.isScrollEnabled = false
        let boerderColor = UIColor(named: Constants.Assetname.Colors.Border.Tertiary)!
        addTopBorderWithColor(color: boerderColor, width: 1)
        box_date.addBottomBorderWithColor(color: boerderColor, width: 1)
    }

}
