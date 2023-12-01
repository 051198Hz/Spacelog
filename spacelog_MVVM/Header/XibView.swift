import UIKit

@IBDesignable
class XibView: UIView {
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        xibSetup()
    }

    
    func xibSetup() {
        let className = String(describing: type(of: self))
        
        let bundle = Bundle(for: type(of: self))
        
        guard let xibView = bundle.loadNibNamed(className, owner: self, options: nil)?.first as? UIView else { return }

        xibView.frame = self.bounds
        xibView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(xibView)
        setUI()
    }
    
    func setUI(){
        print(#function)
    }
    
}
