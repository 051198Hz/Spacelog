//
//  TextView_TMB.swift
//  spacelog_MVVM
//
//  Created by iOS Dev on 2023/11/24.
//

import UIKit

class TextView_TMB: UITextView, UITextViewDelegate {
    
    var contentText: String{
        get{
            return text == Constants.Texts.placeHolder ?  "" : text
        }
    }
    
    @IBInspectable
    var pxfontSize: CGFloat = 16
    
    @IBInspectable
    var pxLineHeight: CGFloat = 24.0

    let maxCount = 60
    let placeHolderText = Constants.Texts.placeHolder
    let placeholderColor = UIColor(named: Constants.Assetname.Colors.Text.Secondary)
    var textCountLabel : Label_TMB?
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.delegate = self
        setUI()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.delegate = self
        setUI()
    }
    
    func setUI(){
        
        //        layer.borderWidth = 1.0
        //        layer.borderColor = UIColor.lightGray.withAlphaComponent(0.7).cgColor
        //        textContainerInset = UIEdgeInsets(top: 16.0, left: 16.0, bottom: 16.0, right: 16.0)
        
        attributedText = makeAttributedText(placeHolderText)
        text = placeHolderText
        textColor = placeholderColor
        textContainerInset = UIEdgeInsets (top: 0, left: -textContainer.lineFragmentPadding, bottom: 0,
        right: -textContainer.lineFragmentPadding)
        
        self.delegate = self
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if textView.text == placeHolderText {
            textView.text = nil
            textColor = placeholderColor
            textView.textColor = UIColor(named: Constants.Assetname.Colors.Text.Primary)
            return
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = placeHolderText
            textView.textColor = placeholderColor
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
//        let currentText = textView.text ?? ""
//        
//        guard let stringRange = Range (range, in: currentText) else { return false }
//        let changedText = currentText.replacingCharacters(in: stringRange, with: text)
//        //        writeContentLabel.text = "\(changedText.count) /100)"
//        if changedText.count > 60 {
//            textCountLabel?.shake()
//        }
//        return changedText.count <= 60
//        
//        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
//        let numberOfChars = newText.count
//        if(numberOfChars > 200){
//            let leng = 200 - textView.text.count
//            textView.text = (textView.text as NSString).replacingCharacters(in: range, with: text.substring(from: 0..<leng))
//        }
        //이전 글자 - 선택된 글자 + 새로운 글자(대체될 글자)
        
        let newLength = textView.text.count - range.length + text.count
        let koreanMaxCount = maxCount + 1
        //글자수가 초과 된 경우 or 초과되지 않은 경우
        if newLength > koreanMaxCount { //11글자
            
            let overflow = newLength - koreanMaxCount //초과된 글자수
            if text.count < overflow {
                return true
            }
            let index = text.index(text.endIndex, offsetBy: -overflow)
            let newText = text[..<index]
            guard let startPosition = textView.position(from: textView.beginningOfDocument, offset: range.location) else { return false }
            guard let endPosition = textView.position(from: textView.beginningOfDocument, offset: NSMaxRange(range)) else { return false }
            guard let textRange = textView.textRange(from: startPosition, to: endPosition) else { return false }
                
            textView.replace(textRange, withText: String(newText))
            
            return false
        }
        return true
        
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.count > maxCount {
        //글자수 제한에 걸리면 마지막 글자를 삭제함.
            textView.text.removeLast()
            textCountLabel?.shake()
        }
        textCountLabel?.text = "\(textView.text.count)/60"

//        if textView.text.count >= 60 {
//            print("too many text")
//        }
    }
    
    func makeAttributedText(_ title : String?) -> NSAttributedString {
        var attributes : [NSAttributedString.Key: Any]? = [:]
        
        let style = NSMutableParagraphStyle()
        let font = UIFont(name: Constants.Assetname.Fonts.Regular, size: pxfontSize)
        // [iOS 특정 버전 이상 분기 처리 사용]
        if #available(iOS 16.4, *) {
            attributes?.updateValue(style, forKey: .paragraphStyle)
            attributes?.updateValue((pxLineHeight - font!.lineHeight) / 2, forKey: .baselineOffset)
        }
        else {
            attributes?.updateValue(style, forKey: .paragraphStyle)
            attributes?.updateValue((pxLineHeight - font!.lineHeight) / 4, forKey: .baselineOffset)
        }
        let letter_spacing = -0.48
        attributes?.updateValue(letter_spacing, forKey: .kern)
        attributes?.updateValue(font!, forKey: .font)

        let attrString = NSAttributedString(string: title ?? "",
                                            attributes: attributes)
        return attrString
    }
    
    func setCountlabel(_ label : Label_TMB){
        self.textCountLabel = label
    }
}
