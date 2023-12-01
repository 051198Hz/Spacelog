//
//  UIButton_Spacelog_Default.swift
//  spacelog_MVVM
//
//  Created by iOS Dev on 2023/11/10.
//

import UIKit

class UIButton_Spacelog_Default: UIButton {

    override var isHighlighted: Bool {
        didSet {
            alpha = isHighlighted ? 0.7 : 1
        }
    }
    
    init(frame : CGRect , image : UIImage) {
        super.init(frame: frame)
        layer.cornerRadius = 8
        if #available(iOS 15, *) {
           // [iOS 15.0 버전 이상 인 경우 분기 처리 내용]
            // [iOS 15.0 버전 이상 인 경우 분기 처리 내용]
 //            var config = UIButton.Configuration.borderless()
             configuration?.baseBackgroundColor = UIColor(named: Constants.Assetname.Colors.Accent)
             configuration?.image = image
 //            config.imagePadding = 8
             configuration?.imagePlacement = .leading
             configuration?.imagePadding = 8
             configuration?.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16)
        }
        else {
           // [iOS 15.0 버전 미만 인 경우 분기 처리 내용]
            titleEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
        }
        
//        setImage(image, for: .normal)
//        bounds = bounds.insetBy(dx: -4, dy: -4)

    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        layer.cornerRadius = 8
        frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: 127, height: 52)
        if #available(iOS 15, *) {
           // [iOS 15.0 버전 이상 인 경우 분기 처리 내용]
            var configuration = UIButton.Configuration.plain()
            
            var attributes : [NSAttributedString.Key: Any]? = [:]
            attributes?.updateValue( -1.08, forKey: .kern)
            attributes?.updateValue(UIFont(name: Constants.Assetname.Fonts.Bold, size: 18)!, forKey: .font)
            let attrString = NSAttributedString(string: "시작하기",
                                                attributes: attributes)
            configuration.attributedTitle = AttributedString(attrString)
            configuration.cornerStyle = .large
            configuration.baseBackgroundColor = UIColor(named: Constants.Assetname.Colors.Accent)
            configuration.image = image(for: .normal)
            configuration.imagePadding = 8
            configuration.imagePlacement = .leading
            configuration.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16)

            self.configuration = configuration
        }
        else {
           // [iOS 15.0 버전 미만 인 경우 분기 처리 내용]
            titleEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
        }
        
//        self.titleLabel?.font =
//        self.titleLabel?.textColor = UIColor(named: Constants.Assetname.Colors.Text.Inverted)
//        tintColor = UIColor(named: Constants.Assetname.Colors.Text.Inverted)
//        self.setTitleColor( UIColor(named: Constants.Assetname.Colors.Text.Inverted), for: .highlighted)
//        self.setTitleColor( UIColor(named: Constants.Assetname.Colors.Text.Inverted), for: .disabled)
//        self.setTitleColor( UIColor(named: Constants.Assetname.Colors.Text.Inverted), for: .normal)
//        self.setTitleColor( , for: .selected)

//        print("awake from nib")
    }
    
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        super.point(inside: point, with: event)
        
        /// 모든 방향에 20만큼 터치 영역 증가
        /// dx: x축이 dx만큼 증가 (음수여야 증가)
        let touchArea = bounds.insetBy(dx: -20, dy: -20)
        return touchArea.contains(point)
    }
    
    // When use titleEdgeInset, need to expand button size widely
//    override var intrinsicContentSize: CGSize {
//        return CGSize(width: super.intrinsicContentSize.width + contentEdgeInsets.left + contentEdgeInsets.right + titleEdgeInsets.left + titleEdgeInsets.right,
//                      height: super.intrinsicContentSize.height + contentEdgeInsets.top + contentEdgeInsets.bottom + titleEdgeInsets.top
//                        + titleEdgeInsets.bottom )
//    }

}
