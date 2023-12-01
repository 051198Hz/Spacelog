//
//  File.swift
//  spacelog_MVVM
//
//  Created by iOS Dev on 2023/11/08.
//

import MapKit
import SnapKit

class SpaceLog_AnnotaionView: MKAnnotationView {
    
    var mapView : MKMapView?
    
    lazy var backgroundView: UIImageView = {
        let view = UIImageView(image: UIImage(named: Constants.Assetname.Images.Marker.frame))
        view.isUserInteractionEnabled = true
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    lazy var badgeView: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Constants.Assetname.Fonts.Regular, size: 12)
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = UIColor(named: Constants.Assetname.Colors.Accent)
        label.layer.cornerRadius = 12
        label.clipsToBounds = true
        return label
    }()
    
    lazy var customImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleToFill
        view.layer.cornerRadius = 6
        view.clipsToBounds = true
        return view
    }()
    
    @objc func action( _ sender : Any){
        print(#function)
    }
    
    lazy var stacView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [customImageView])
        view.spacing = 4
        view.axis = .vertical
        return view
    }()
    
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        configUI()
//        canShowCallout = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configUI() {
        self.addSubview(backgroundView)
        backgroundView.addSubview(stacView)
        
        backgroundView.addSubview(badgeView)
        
        backgroundView.snp.makeConstraints {
            $0.height.equalTo(72)
            $0.width.equalTo(64)
        }
        
        stacView.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-12)
            $0.top.equalToSuperview().offset(4)
            $0.left.equalToSuperview().offset(4)
            $0.right.equalToSuperview().offset(-4)
        }
        
//        let controllView = UIControl(frame: CGRect(x: 0, y: 0, width: 56, height: 56))
//        controllView.addTarget(self, action: #selector(action(_:)), for: .touchUpInside)
//        let tap = UILongPressGestureRecognizer(target: self, action: #selector(tapHandler))
//        tap.minimumPressDuration = 0
//        backgroundView.addGestureRecognizer(tap)
//        backgroundView.isUserInteractionEnabled = true
        
        //        customImageView.addSubview(controllView)
//        self.isUserInteractionEnabled = false
        self.canShowCallout = false
    }

    
//    @objc func tapHandler(gesture: UITapGestureRecognizer) {
//        // there are seven possible events which must be handled
//        if gesture.state == .began {
//            print("touch began")
//
//            return
//        }
////        if gesture.state == .changed {
////            print("touch changed")
////            return
////        }
//        if gesture.state == .possible || gesture.state == .recognized {
//            print("touch possible or recognized")
//
//            return
//        }
//        // the three remaining states are
//        // .cancelled, .failed, and .ended
//        // in all three cases, must return to the normal button look:
//    }
    
    // Annotation도 재사용을 하므로 재사용 전 값을 초기화 시켜서 다른 값이 들어가는 것을 방지
    override func prepareForReuse() {
        super.prepareForReuse()
        customImageView.image = nil
        badgeView.text = nil

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIView.animate(withDuration: 0.1, delay: 0.0, options: [.curveEaseIn,.allowUserInteraction], animations: { [weak self] in
            // HERE
            self?.mapView?.isZoomEnabled = false
            self?.transform = CGAffineTransform.identity.scaledBy(x: 1.2, y: 1.2) // Scale your image
            self?.layoutIfNeeded()
        })
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIView.animate(withDuration: 0.05, delay: 0.0, options: [.curveEaseIn,.allowUserInteraction], animations: { [weak self] in
            // HERE
            self?.transform = CGAffineTransform.identity
            self?.layoutIfNeeded()
            self?.mapView?.isZoomEnabled = true

        })
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIView.animate(withDuration: 0.05, delay: 0.0, options: [.curveEaseIn,.allowUserInteraction], animations: { [weak self] in
            // HERE

            self?.transform = CGAffineTransform.identity
            self?.layoutIfNeeded()
            self?.mapView?.isZoomEnabled = true

        })
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIView.animate(withDuration: 0.05, delay: 0.0, options: [.curveEaseIn,.allowUserInteraction], animations: { [weak self] in
            // HERE

            self?.transform = CGAffineTransform.identity
            self?.layoutIfNeeded()
            self?.mapView?.isZoomEnabled = true

        })
    }
    
    
    // 이 메서드는 annotation이 뷰에서 표시되기 전에 호출됩니다.
    // 즉, 뷰에 들어갈 값을 미리 설정할 수 있습니다
    override func prepareForDisplay() {
        super.prepareForDisplay()
        
        guard let annotation = annotation as? SpaceLogAnnotation else { return }
        self.mapView = annotation.mapView
        if let text = annotation.badgeCount{
            badgeView.text = text
            badgeView.snp.makeConstraints {
                $0.centerX.equalTo(backgroundView.snp.trailing)
                $0.centerY.equalTo(backgroundView.snp.top)
                $0.height.equalTo(24)
                $0.width.equalTo(24)
            }
        }
        
        if let imageName = annotation.imageName,
           let image = UIImage(named: imageName){
            customImageView.image = image
        }
        
        isDraggable = false
        // 이미지의 크기 및 레이블의 사이즈가 변경될 수도 있으므로 레이아웃을 업데이트 한다.
        setNeedsLayout()
        
        // 참고. drawing life cycle :
        // setNeedsLayout를 통해 다음 런루프에서 레이아웃을 업데이트하도록 예약
        // -> layoutSubviews을 통해 레이아웃 업데이트
        // layoutSubviews를 쓰려면 setNeedsLayout도 항상 같이 사용해야 한다고 하네요.
    }
    
    // MKAnnotationView의 layoutSubviews를 재정의 해줍니다.
    override func layoutSubviews() {
        super.layoutSubviews()
        // MKAnnotationView 크기를 backgroundView 크기 만큼 정해줌.
        bounds.size = CGSize(width: 64, height: 72)
        centerOffset = CGPoint(x: 0, y: -36)
    }
}

