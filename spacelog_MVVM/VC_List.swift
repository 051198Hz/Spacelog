//
//  VC_List.swift
//  spacelog_MVVM
//
//  Created by iOS Dev on 2023/12/07.
//

import UIKit

class VC_List: VC_Default {

    @IBOutlet weak var listView_posts: UICollectionView!
    @IBOutlet weak var View_Header: Header_Spacelog!
    var title_Header : String!
    lazy var posts : [SpaceLogPosting] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listView_posts.delegate = self
        listView_posts.dataSource = self

        registerNib()
    }
    
    override func setUI(){
        
        if title_Header == nil{
            title_Header = "주소 뜨게 해주세요"
        }
        guard let title_Header = title_Header else {return}
        View_Header.text_header = title_Header
        View_Header.BorderColor = UIColor(named: Constants.Assetname.Colors.Border.Tertiary)
        
        listView_posts.backgroundColor = UIColor(named: Constants.Assetname.Colors.Background.Primary)
        
        (listView_posts.collectionViewLayout as? UICollectionViewFlowLayout)?.estimatedItemSize = .zero
        
    }
    
    private func registerNib() {
        let nibName = UINib(nibName: "Cell_Spacelog", bundle: nil)
        listView_posts.register(nibName, forCellWithReuseIdentifier: "cell_feed_Spacelog")
    }
    

}

extension VC_List : UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 11
        
//        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell_feed_Spacelog", for: indexPath) as! Cell_Spacelog
        
        cell.imageView.image = UIImage(named: "sample2")
        cell.label_date.text = "2023년 10월 28일 토요일 13:49"
        cell.textView.contentText = "우와아앙앙아마이렌!!!우와아앙앙아마이렌!!!우와아앙앙아마이렌!!!우와아앙앙아마이렌!!!우와아앙앙아마이렌!!!우와아앙앙아마이렌!!!우와아앙앙아마이렌!!!우와아앙앙아마이렌!!!우와아앙앙아마이렌!!!우와아앙앙아마이렌!!!"
        
        return cell
    }
    
    
}

extension VC_List: UICollectionViewDelegateFlowLayout {
    // 위 아래 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      
      return CGSize(width: collectionView.frame.width, height: Constants.heightFeedCell)
      
  }
}

