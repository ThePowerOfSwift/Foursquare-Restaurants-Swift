//
//  Restaurant.swift
//  4square
//
//  Created by Mihail Șalari on 11.04.2016.
//  Copyright © 2016 PlatinumCode. All rights reserved.
//

import Foundation
import ObjectMapper

class Restaurant: Mappable {
    
    var lat: Float?
    var lng: Float?
    var address: String?
    var name: String?
    
    required init?(_ map: Map) { }
    
    // Mappable
    func mapping(map: Map) {
        lat     <- map["venue.location.lat"]
        lng     <- map["venue.location.lng"]
        address <- map["venue.location.address"]
        name    <- map["venue.name"]
    }
}
