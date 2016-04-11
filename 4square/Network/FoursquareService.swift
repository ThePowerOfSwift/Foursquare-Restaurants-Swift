//
//  FoursquareService.swift
//  4square
//
//  Created by Mihail Șalari on 11.04.2016.
//  Copyright © 2016 PlatinumCode. All rights reserved.
//

import Foundation
import ObjectMapper

struct FoursquareService {
    
    func getFoursquare(completion: [Restaurant]? -> Void) {
        
        if let foursquareURL = NSURL(string: ApiURL.restaurantsLists) {
            let networkOperation = NetworkOperation(url: foursquareURL)
            
            networkOperation.downloadJSONFromURL {
                (let JSONArray) in
                let user = Mapper<Response>().map(JSONArray)
                completion(user?.restaurants)
            }
            
        } else {
            print("FoursquareService: getFoursquare(): Could not construct a valid URL")
        }
    }
}
