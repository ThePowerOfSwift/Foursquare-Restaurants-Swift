//
//  Response.swift
//  4square
//
//  Created by Mihail Șalari on 11.04.2016.
//  Copyright © 2016 PlatinumCode. All rights reserved.
//

import Foundation
import ObjectMapper

class Response: Mappable {
    
    var restaurants: [Restaurant]?
    
    required init?(_ map: Map) { }
    
    // Mappable
    func mapping(map: Map) {
        restaurants    <- map["response.groups.0.items"]
    }
    
}
