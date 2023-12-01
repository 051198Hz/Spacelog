//
//  FloatingButton_TMB.swift
//  spacelog_MVVM
//
//  Created by iOS Dev on 2023/11/30.
//

import UIKit

class FloatingButton_TMB: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setButtonCircle(frame.width/2)
        setShadow()
    }
    
    func setShadow(){
        layer.shadowColor = UIColor.black.cgColor // 색깔
        layer.masksToBounds = false  // 내부에 속한 요소들이 UIView 밖을 벗어날 때, 잘라낼 것인지. 그림자는 밖에 그려지는 것이므로 false 로 설정
        layer.shadowOffset = CGSize(width: 0, height: 4) // 위치조정
        layer.shadowRadius = 3 // 반경
        layer.shadowOpacity = 0.3 // alpha값
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setButtonCircle(_ radius : CGFloat ){
        layer.cornerRadius = radius
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        UIView.animate(withDuration: 0.1, delay: 0.0, options: [.curveEaseIn,.allowUserInteraction], animations: { [weak self] in
            // HERE
            self?.transform = CGAffineTransform.identity.scaledBy(x: 1.2, y: 1.2) // Scale your image
            self?.layoutIfNeeded()
        })
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        UIView.animate(withDuration: 0.05, delay: 0.0, options: [.curveEaseIn,.allowUserInteraction], animations: { [weak self] in
            // HERE
            self?.transform = CGAffineTransform.identity
            self?.layoutIfNeeded()

        })
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIView.animate(withDuration: 0.05, delay: 0.0, options: [.curveEaseIn,.allowUserInteraction], animations: { [weak self] in
            // HERE

            self?.transform = CGAffineTransform.identity
            self?.layoutIfNeeded()

        })
    }
    
}
