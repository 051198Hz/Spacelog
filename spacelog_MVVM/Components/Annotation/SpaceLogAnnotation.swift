//
//  SpaceLogAnnotation.swift
//  spacelog_MVVM
//
//  Created by iOS Dev on 2023/11/30.
//

import MapKit

class SpaceLogAnnotation: NSObject, MKAnnotation {

    // This property must be key-value observable, which the `@objc dynamic` attributes provide.
    @objc dynamic var coordinate: CLLocationCoordinate2D
    var badgeCount: String?
    var subtitle: String?
    var imageName: String?
    var title: String?
    var mapView : MKMapView

    init(badgeCount: String?, coordinate: CLLocationCoordinate2D, mapView : MKMapView) {
        self.title = badgeCount
        self.badgeCount = badgeCount
        self.coordinate = coordinate
        self.mapView = mapView
    }
}
