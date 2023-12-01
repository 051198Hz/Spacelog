//
//  Button_Header_Item.swift
//  spacelog_MVVM
//
//  Created by iOS Dev on 2023/11/09.
//

import UIKit

class Button_Header_Item: UIButton {
    
    override var isHighlighted: Bool {
        didSet {
            alpha = isHighlighted ? 0.3 : 1
            backgroundColor = isHighlighted ? .clear.withAlphaComponent(0.5) : .clear
        }
    }
    
    init(frame : CGRect , image : UIImage?, title : String?) {
        super.init(frame: frame)
        layer.frame = CGRect(x: 0, y: 0, width: frame.width , height: frame.height )
        layer.cornerRadius = 8
        bounds = bounds.insetBy(dx: -4, dy: -4)
        

//        inset
        if let image = image {
            setImage(image, for: .normal)
        }
        if let title = title{
            setAttributedTitle(makeAttributedText(title), for: .normal)
        }
        
//        if let label = titleLabel{
//            label.font =  UIFont(name: Constants.Assetname.Fonts.Regular, size: 16)
//        }
    }
    
    func makeAttributedText(_ title : String?) -> NSAttributedString {
        var attributes : [NSAttributedString.Key: Any]? = [:]
        
        let style = NSMutableParagraphStyle()
        let pxLineHeight = 24.0
        let font = UIFont(name: Constants.Assetname.Fonts.Regular, size: 16)
//        if #available(iOS 16.4, *) {
//            attributes?.updateValue(style, forKey: .paragraphStyle)
//            attributes?.updateValue((pxLineHeight - font!.lineHeight) / 2, forKey: .baselineOffset)
//        }
//        else {
//            attributes?.updateValue(style, forKey: .paragraphStyle)
//            attributes?.updateValue((pxLineHeight - font!.lineHeight) / 4, forKey: .baselineOffset)
//        }
        let letter_spacing = -0.48
        attributes?.updateValue(letter_spacing, forKey: .kern)
        attributes?.updateValue(font!, forKey: .font)

        let attrString = NSAttributedString(string: title ?? "",
                                            attributes: attributes)
        return attrString
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        super.point(inside: point, with: event)

        /// 모든 방향에 20만큼 터치 영역 증가
        /// dx: x축이 dx만큼 증가 (음수여야 증가)
        let touchArea = bounds.insetBy(dx: -20, dy: -20)
        return touchArea.contains(point)
    }
    
}
