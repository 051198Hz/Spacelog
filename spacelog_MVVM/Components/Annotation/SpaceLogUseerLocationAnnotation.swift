import MapKit

class SpaceLogUseerLocationAnnotation: NSObject, MKAnnotation {

    // This property must be key-value observable, which the `@objc dynamic` attributes provide.
    @objc dynamic var coordinate: CLLocationCoordinate2D
    var badgeCount: String?
    var subtitle: String?
    var title: String?

    init(coordinate : CLLocationCoordinate2D) {
        self.title = ""
        self.coordinate = coordinate
    }
}
