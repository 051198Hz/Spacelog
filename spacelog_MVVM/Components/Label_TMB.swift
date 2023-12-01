//
//  label_ex.swift
//  animation_ex
//
//  Created by iOS Dev on 2023/09/15.
//

import UIKit

@IBDesignable
class Label_TMB: UILabel, CAAnimationDelegate {
    
//    var animationItem : DispatchWorkItem?
    
    var attributes : [NSAttributedString.Key: Any]? = [:]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setAttributedText()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setAttributedText()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setAttributedText()
    }
    
    
    func setAttributedText(){
        let attrString = NSAttributedString(string: text ?? "", attributes: attributes)
        self.attributedText = attrString
    }
    
    func shake(){
        
        DispatchQueue.main.async { [weak self] in
            self?.textColor = .red
        }
        
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.delegate = self
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.6
        animation.values = [-5.0, 5.0, -5.0, 5.0, -5.0, 5.0, -3.0, 3.0, 0.0 ]
//        animationItem = DispatchWorkItem { [weak self] in
//            self?.textColor = UIColor(named: Constants.Assetname.Colors.Text.Secondary)
//          }
        layer.add(animation, forKey: "shake")

    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag {
            textColor = UIColor(named: Constants.Assetname.Colors.Text.Secondary)
        }
    }
    
    @IBInspectable public
    var letter_spacing : CGFloat = -0.5
    {
        didSet{
            attributes?.updateValue(letter_spacing, forKey: .kern)
        }
    }
    
    
    @IBInspectable public
    var pxLineHeight : CGFloat = 0.0 {
        didSet{
            let style = NSMutableParagraphStyle()

//            let pxLineHeight : CGFloat = round( (lineHeight / 100) * self.font.pointSize )
            
            
            style.maximumLineHeight = pxLineHeight
            style.minimumLineHeight = pxLineHeight
            print(pxLineHeight)
                        
            // [iOS 특정 버전 이상 분기 처리 사용]
            if #available(iOS 16.4, *) {
                attributes?.updateValue(style, forKey: .paragraphStyle)
                attributes?.updateValue((pxLineHeight - font.lineHeight) / 2, forKey: .baselineOffset)
            }
            else {
                attributes?.updateValue(style, forKey: .paragraphStyle)
                attributes?.updateValue((pxLineHeight - font.lineHeight) / 4, forKey: .baselineOffset)
            }
            
//            print(".font.lineHeight", self.font.lineHeight)
//            print(".font.pointSize", self.font.pointSize)
//            print(".intrinsicContentSize.height", self.intrinsicContentSize.height)
//            print("pxLineHeight", pxLineHeight)

        }
    }
    
    @IBInspectable public
    var underline : Bool = false {
        didSet{
            if underline {
                attributes?.updateValue(NSUnderlineStyle.single.rawValue, forKey: .underlineStyle)
            }
        }
    }
    
    
}
