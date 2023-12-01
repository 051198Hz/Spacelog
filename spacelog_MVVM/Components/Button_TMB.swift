//
//  TMB_Button.swift
//  spacelog_MVVM
//
//  Created by iOS Dev on 2023/11/24.
//

import UIKit

class Button_TMB: UIButton {
    
    override var isHighlighted: Bool {
        didSet {
            alpha = isHighlighted ? 0.3 : 1
//            backgroundColor = isHighlighted ? .clear.withAlphaComponent(0.5) : .clear
        }
    }
    
    var isTitleFontBold : Bool = false
    
    override init(frame: CGRect) { // by code
        super.init(frame: frame)
        layer.cornerRadius = 8
        setAttributedTitle(makeAttributedText( title(for: .normal)), for: .normal)
        setTitleColor(UIColor(named: Constants.Assetname.Colors.Text.Inverted), for: .normal)
        print(#function)
        backgroundColor = UIColor(named: Constants.Assetname.Colors.Accent)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func setTitle(_ title: String?, for state: UIControl.State) {
        setAttributedTitle(makeAttributedText( title), for: state)

    }
    
    override func setImage(_ image: UIImage?, for state: UIControl.State) {
        super.setImage(image, for: state)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: -8)
        contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 8
        
        setAttributedTitle(makeAttributedText(title(for: .normal)), for: .normal)
    }
    

    func makeAttributedText(_ title : String?) -> NSAttributedString {
        var attributes : [NSAttributedString.Key: Any]? = [:]
        
        let style = NSMutableParagraphStyle()
        let pxLineHeight = 24.0
        let font = isTitleFontBold ? UIFont(name: Constants.Assetname.Fonts.Bold, size: 18) : UIFont(name: Constants.Assetname.Fonts.Regular, size: 16)
//        if #available(iOS 16.4, *) {
//            attributes?.updateValue(style, forKey: .paragraphStyle)
//            attributes?.updateValue((pxLineHeight - font!.lineHeight) / 2, forKey: .baselineOffset)
//        }
//        else {
//            attributes?.updateValue(style, forKey: .paragraphStyle)
//            attributes?.updateValue((pxLineHeight - font!.lineHeight) / 4, forKey: .baselineOffset)
//        }
        let letter_spacing = -1.08
        attributes?.updateValue(letter_spacing, forKey: .kern)
        attributes?.updateValue(font!, forKey: .font)

        let attrString = NSAttributedString(string: title ?? "",
                                            attributes: attributes)
        return attrString
    }
}
