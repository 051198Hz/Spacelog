//
//  VC_main.swift
//  spacelog_MVVM
//
//  Created by iOS Dev on 2023/11/07.
//

import UIKit
import MapKit
import Mantis

class VC_main: VC_Default {
    //브랜치 네이버맵 체크용 주석

    @IBOutlet weak var Header_bar: Header_Spacelog!
    
    @IBOutlet weak var mapView: MKMapView!
//    var button_post: Button_TMB!/
    var button_myLocation : FloatingButton_TMB!
    var button_post:FloatingButton_TMB!
    var locationManager = CLLocationManager()
    var annotation_userLocation : SpaceLogUseerLocationAnnotation!
    var userLocationforPost : CLLocationCoordinate2D?
    override func viewDidLoad() {
        super.viewDidLoad()
        addBarButton()
        uiSet()
        locationSet()
        mapSet()
    }
    
    @objc private func buttonPressed(_ uibutton: UIButton) {
        print(uibutton)
    }

    func addBarButton(){
        let item_button_search = createBarButtonItem(CGRect(x: 0, y: 0, width: 24, height: 24), Constants.Assetname.Images.Symbol.Search) {
            print(#function)
        }
        let item_button_menu = createBarButtonItem(CGRect(x: 0, y: 0, width: 24, height: 24), Constants.Assetname.Images.Symbol.Menu){
            print(#function)
        }
        Header_bar.NavBar.topItem?.setRightBarButtonItems([item_button_menu, item_button_search], animated: true)
    }
    
    func make_floating_button( _ image : String, _ color : String , _ action : @escaping ()->() ) -> FloatingButton_TMB {
        
        let btn = FloatingButton_TMB(frame: CGRect(x: 0, y: 0, width: 64, height: 64))
        btn.setImage(UIImage(named: image), for: .normal)
        btn.backgroundColor = UIColor(named: color)
        btn.addAction {
            action()
        }
        return btn
    }
    
    func createBarButtonItem(_ frame : CGRect, _ image : String, _ action : @escaping ()->() ) -> UIBarButtonItem {
        let button = Button_Header_Item(frame: frame, image: UIImage(named: image), title: nil)
        button.addAction {
            action()
        }
        return UIBarButtonItem(customView: button )
    }
    
    func uiSet(){
        button_post = make_floating_button(Constants.Assetname.Images.Symbol.Camera,
                                           Constants.Assetname.Colors.FAB.Primary){
            [weak self] in
            self?.userLocationforPost = self?.mapView.userLocation.coordinate
            let pickerController = UIImagePickerController()
            pickerController.delegate = self
            pickerController.sourceType = .camera
            self?.present(pickerController, animated: true)
        }
        view.addSubview(button_post)
        button_post.snp.makeConstraints {
            $0.width.equalTo(64)
            $0.height.equalTo(64)
            $0.right.equalTo(view.safeAreaLayoutGuide).offset(-16)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-16)
        }
        button_myLocation = make_floating_button(Constants.Assetname.Images.Symbol.GPS,
                                Constants.Assetname.Colors.FAB.Secondary){
            [weak self] in
               if let center = self?.mapView.userLocation.coordinate{
                   self?.mapView.setCenter(center, animated: true)
               }
        }
        view.addSubview(button_myLocation)
        button_myLocation.snp.makeConstraints {
            $0.width.equalTo(64)
            $0.height.equalTo(64)
            $0.right.equalTo(view.safeAreaLayoutGuide).offset(-16)
            $0.bottom.equalTo(button_post.snp.top).offset(-16)
        }
    }
}

extension VC_main : MKMapViewDelegate, UIGestureRecognizerDelegate{
    
    func mapSet(){
        let location = CLLocationCoordinate2D(latitude: 37.5470141, longitude: 127.1078036)
        let location1 = CLLocationCoordinate2D(latitude: 37.5470574, longitude: 127.107617) //피오디디
        let location2 = CLLocationCoordinate2D(latitude: 37.547145, longitude: 127.107792) // 시너리커피
        let location3 = CLLocationCoordinate2D(latitude: 37.5471836, longitude: 127.107617) //브런치파스타

        let location4 = CLLocationCoordinate2D(latitude: 36.8095654, longitude: 127.1441493)
        
        mapView.delegate = self
        mapView.show_Annotation_UserLocation()
        mapView.setRegion(MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta: 0.0005, longitudeDelta: 0.0005)), animated: true)
        
        
//        1. 사용할 어노테이션뷰 클래스들을 등록
        mapView.register(SpaceLog_AnnotaionView.self, forAnnotationViewWithReuseIdentifier: NSStringFromClass(SpaceLog_AnnotaionView.self))
        mapView.register(Spacelog_UserAnnotationView.self, forAnnotationViewWithReuseIdentifier: NSStringFromClass(Spacelog_UserAnnotationView.self))

        
//        mapView.register(Spacelog_UserAnnotationView.self, forAnnotationViewWithReuseIdentifier: NSStringFromClass(Spacelog_UserAnnotationView.self))
        
        //위치 기반 내위치 마커
//        if let location = locationManager.location{
//            annotation_userLocation = createSpaceLogUserAnnotation(coordinate: location.coordinate)
//            mapView.addAnnotation(annotation_userLocation)
//        }

//        2. 어노테이션 생성
        mapView.addAnnotation(createSpaceLogAnnotation(coordinate: location1, imageName: "sampleImg1", badgeCount: 13, mapView : mapView))
        mapView.addAnnotation(createSpaceLogAnnotation(coordinate: location2, imageName: "sampleImg2", mapView : mapView))
        mapView.addAnnotation(createSpaceLogAnnotation(coordinate: location3, imageName: "sampleImg3", mapView : mapView))
        
        mapView.addAnnotation(createSpaceLogAnnotation(coordinate: location4, imageName: "sampleImg3", mapView : mapView))
    }
    
    private func addPointPin(coordinate : CLLocationCoordinate2D) -> MKAnnotation{
            let pin = MKPointAnnotation()
            pin.coordinate = coordinate
            pin.title = "새싹 영등포캠퍼스"
            pin.subtitle = "전체 3층짜리 건물"
            return pin
    }
    
    private func createSpaceLogUserAnnotation(coordinate: CLLocationCoordinate2D) -> SpaceLogUseerLocationAnnotation {
        let annotation = SpaceLogUseerLocationAnnotation(
                                            coordinate: coordinate)
        
        return annotation
    }
    
    private func createSpaceLogAnnotation(coordinate: CLLocationCoordinate2D, imageName : String, mapView : MKMapView) -> SpaceLogAnnotation {
        let annotation = SpaceLogAnnotation(badgeCount: nil ,
                                            coordinate: coordinate, mapView: mapView)
        // 이미지 이름 설정
        annotation.imageName = imageName
        // mapView에 Annotation 추가
        
        return annotation
    }
    
    private func createSpaceLogAnnotation(coordinate: CLLocationCoordinate2D, imageName : String, badgeCount : Int, mapView : MKMapView) -> SpaceLogAnnotation {
        let annotation = SpaceLogAnnotation(badgeCount: badgeCount.toString() ,
                                            coordinate: coordinate, mapView: mapView)
        // 이미지 이름 설정
        annotation.imageName = imageName
        // mapView에 Annotation 추가
        
        return annotation
    }
    
    func setupAnnotationView(for annotation: SpaceLogAnnotation, on mapView: MKMapView) -> MKAnnotationView {
        // dequeueReusableAnnotationView: 식별자를 확인하여 사용가능한 뷰가 있으면 해당 뷰를 반환
        return mapView.dequeueReusableAnnotationView(withIdentifier: NSStringFromClass(SpaceLog_AnnotaionView.self), for: annotation)
    }
    
    func setupAnnotationView(for annotation: SpaceLogUseerLocationAnnotation, on mapView: MKMapView) -> MKAnnotationView {
        // dequeueReusableAnnotationView: 식별자를 확인하여 사용가능한 뷰가 있으면 해당 뷰를 반환
        return mapView.dequeueReusableAnnotationView(withIdentifier: NSStringFromClass(Spacelog_UserAnnotationView.self), for: annotation)
    }
    
//    func setupUserAnnotationView(for annotation: MKUserLocation, on mapView: MKMapView) -> MKAnnotationView {
//        // dequeueReusableAnnotationView: 식별자를 확인하여 사용가능한 뷰가 있으면 해당 뷰를 반환
//        return mapView.dequeueReusableAnnotationView(withIdentifier: NSStringFromClass(Spacelog_UserAnnotationView.self), for: annotation)
//    }

    //유저 위치 변할때 호출 함수
//    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
//        print(userLocation.coordinate)
//    }
    
    //여기서 어노테이션의 타입을 확인해서 해당 타입에 맞는 어노테이션뷰를 반환해준다.
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//         현재 위치 표시(점)도 일종에 어노테이션이기 때문에, 이 처리를 안하게 되면, 유저 위치 어노테이션도 변경 된다.
//        guard !annotation.isKind(of: MKUserLocation.self) else { return nil }
        
        var annotationView: MKAnnotationView?
        
        if annotation is MKUserLocation {
            let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "userLocation")
            annotationView.image = UIImage(named: Constants.Assetname.Images.Symbol.myLocation)
            annotationView.isUserInteractionEnabled = false
            //나중에 유저로케이션에 해당하는 이미지로 교체해야함
//            let annotationView = setupUserAnnotationView(for: annotation as! MKUserLocation, on: mapView)
//            annotationView.image =
            return annotationView
        }
        
        // 다운캐스팅이 되면 CustomAnnotation를 갖고 CustomAnnotationView를 생성
        if annotation is SpaceLogAnnotation {
            annotationView = setupAnnotationView(for: annotation as! SpaceLogAnnotation, on: mapView)
        }
        
//        if annotation is SpaceLogUseerLocationAnnotation{
//            annotationView = setupAnnotationView(for: annotation as! SpaceLogUseerLocationAnnotation, on: mapView)
//
//        }
        
        
        return annotationView
    }

}

extension VC_main : CLLocationManagerDelegate {
    
    func locationSet(){
        locationManager.delegate = self
        // 앱을 사용할 때만 위치 정보를 허용할 경우 호출
        locationManager.requestWhenInUseAuthorization()
        // 위치 정보 제공의 정확도를 설정할 수 있다.
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        // 위치 정보를 지속적으로 받고 싶은 경우 이벤트를 시작
        locationManager.startUpdatingLocation()
    }
    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        
//        if let last = locations.last{
//            annotation_userLocation.coordinate = last.coordinate
//        }
//
//    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse:  // Location services are available.
            mapView.show_Annotation_UserLocation()
            break
            
        case .restricted, .denied:  // Location services currently unavailable.
            break
            
        case .notDetermined:        // Authorization not determined yet.
           manager.requestWhenInUseAuthorization()
            break
            
        default:
            break
        }
    }
    
    
}

extension VC_main: UIImagePickerControllerDelegate, UINavigationControllerDelegate, CropViewControllerDelegate {
    
    func cropViewControllerDidCrop(_ cropViewController: Mantis.CropViewController, cropped: UIImage, transformation: Mantis.Transformation, cropInfo: Mantis.CropInfo) {
        
        cropViewController.dismiss(animated: true)
        print(#function)
        
        guard let VC = self.storyboard?.instantiateViewController(withIdentifier: "VC_Posting") as? VC_Posting else { return }
        guard let postLocation = userLocationforPost else {return}
        VC.postCoordinate = postLocation
        VC.imgCropped = cropped
        VC.modalPresentationStyle = .fullScreen
        present(VC, animated: true)
    }
    
    func cropViewControllerDidCancel(_ cropViewController: Mantis.CropViewController, original: UIImage) {
        cropViewController.dismiss(animated: true)
        print(#function)
    }
    
    // delegate Method 들어가는부분
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true)

        guard let image = info[.originalImage] as? UIImage else {
            print("No image found")
            return
        }
        
        var config = Mantis.Config()
        config.cropViewConfig.cropShapeType = .square
        config.ratioOptions = [.square]
        
        let cropViewController = Mantis.cropViewController(image: image, config: config)
        cropViewController.delegate = self
        cropViewController.modalPresentationStyle = .fullScreen
        present(cropViewController, animated: true)

    }
}

extension VC_main{
    
}
