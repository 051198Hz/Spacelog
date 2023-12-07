//
//  VC_Posting.swift
//  spacelog_MVVM
//
//  Created by iOS Dev on 2023/11/24.
//

import UIKit
import Supabase
import MapKit

class VC_Posting: VC_Default {
    
    @IBOutlet weak var View_Header: Header_Spacelog!
    @IBOutlet weak var View_container_button: View_container_button!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var textView_content: TextView_TMB!
    @IBOutlet weak var bottom_constraints: NSLayoutConstraint!
    @IBOutlet weak var view_cotainer_image: UIView!
    
    @IBOutlet weak var view_textView: UIView!
    
    @IBOutlet weak var label_contentCount: Body_Label!
    
    @IBOutlet weak var imageView: UIImageView!
    
    var postCoordinate : CLLocationCoordinate2D!
    var imgCropped : UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
        setUI()
        addBarButton()
        //        addKeyboardNotification()
        // Do any additional setup after loading the view.
    }
    func setDelegate(){
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.addKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.removeKeyboardNotifications()
    }
    
    func setUI(){
        addBarButton()
        textView_content.setCountlabel(label_contentCount)
        imageView.image = imgCropped
        view_textView.addBottomBorderWithColor(color: UIColor(named: Constants.Assetname.Colors.Text.Tertiary)!, width: 1)
    }
    @IBAction func pressed_btn_posting(_ sender: Any) {
         Task { [weak self] in
//            await self?.upload_post()
             await self?.download_image()
            self?.dismiss(animated: true)
        }
    }
    
    func addBarButton(){
        
        let button_menu = Button_Header_Item(frame: CGRect(x: 0, y: 0, width: 56, height: 32), image: nil, title: "기록하기")
        //        button_menu.bounds = button_menu.bounds.insetBy(dx: -4, dy: 0)
        
        button_menu.addAction { [weak self] in
            self?.view.endEditing(true)
            print(#function)
            Task {
//                await self?.upload_post()
                await self?.download_image()
            }
        
        }
        //            .addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
        
        let view = UIView(frame: .init(x: 0, y: 0, width: 24, height: 32))
        
        view.addSubview(button_menu)
        button_menu.layer.position.x -= 32
        
        let item_button_menu = UIBarButtonItem(customView: view )
        
        View_Header.NavBar.topItem?.setRightBarButtonItems([ item_button_menu],  animated: true)
        
    }
    
    //    @objc private func buttonPressed(_ uibutton: UIButton) {
    //        print(uibutton)
    //        view.endEditing(true)
    //    }
    
    func upload_post() async{
        let lat = "\(postCoordinate.latitude)"
        let long = "\(postCoordinate.longitude)"
        let text = textView_content.contentText
        let posting = SpaceLogPosting(lat: lat, long: long ,text: text, id_owner: "")
        let image = imageView.image!
        
        await APIManager.sharedInstance.uploadPostingRequestAPI(posting: posting, image: image)
        let postings = await APIManager.sharedInstance.downloadPostingRequestAPI()
        print(postings)
    }
    
    func download_image() async{
        let url = "33642E73-3FC8-4D84-B74A-867B3CB8536D_2023-12-01_17:10:05.jpg"
        guard let image = await APIManager.sharedInstance.downloadImageRequestAPI(imageURL: url) else {
            print("faile to load image")
            return }
        DispatchQueue.main.async {
            [weak self] in
            self?.imageView.image = UIImage(data: image)
        }
    }
    
}

extension VC_Posting{
    
    // 노티피케이션을 추가하는 메서드
    func addKeyboardNotifications(){
        // 키보드가 나타날 때 앱에게 알리는 메서드 추가
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification , object: nil)
        // 키보드가 사라질 때 앱에게 알리는 메서드 추가
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // 노티피케이션을 제거하는 메서드
    func removeKeyboardNotifications(){
        // 키보드가 나타날 때 앱에게 알리는 메서드 제거
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification , object: nil)
        // 키보드가 사라질 때 앱에게 알리는 메서드 제거
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    // 키보드가 나타났다는 알림을 받으면 실행할 메서드
    @objc func keyboardWillShow(_ noti: NSNotification){
        // 키보드의 높이만큼 화면을 올려준다.
        if let keyboardFrame: NSValue = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            
            let keyboardHeight = keyboardRectangle.height
            //            self.View_container_button.frame.origin.y -= keyboardHeight
            bottom_constraints.constant = keyboardHeight -             self.view.safeAreaInsets.bottom
            
            UIView.animate(withDuration: 0.2) { [weak self] in
                //2
                self?.view.layoutIfNeeded()
                
            }
            self.scrollView.scrollRectToVisible(self.view_textView.frame, animated: true)
        }
    }
    
    // 키보드가 사라졌다는 알림을 받으면 실행할 메서드
    @objc func keyboardWillHide(_ noti: NSNotification){
        // 키보드의 높이만큼 화면을 내려준다.
        if let keyboardFrame: NSValue = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            //            self.View_container_button.frame.origin.y += keyboardHeight
            bottom_constraints.constant = 0
            UIView.animate(withDuration: 0.2) {
                //2
                self.view.layoutIfNeeded()
            }
            
        }
    }
    
}
