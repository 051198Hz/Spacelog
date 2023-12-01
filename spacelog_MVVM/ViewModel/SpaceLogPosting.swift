//
//  File.swift
//  spacelog_MVVM
//
//  Created by iOS Dev on 2023/11/06.
//

//ViewModel
import Foundation
import CoreLocation

struct SpaceLogPosting: Codable {
    var id : Int?
    var created_at : String?
    var lat : String
    var long : String
//    var location : CLLocationCoordinate2D
    var text : String
//    var date_created : Date =
    var id_owner : String
    var image_name : String?
}
