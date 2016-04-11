//
//  NetworkOperation.swift
//  4square
//
//  Created by Mihail Șalari on 11.04.2016.
//  Copyright © 2016 PlatinumCode. All rights reserved.
//

import Foundation
class NetworkOperation {
    
    lazy var config: NSURLSessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
    lazy var session: NSURLSession = NSURLSession(configuration: self.config)
    let queryURL: NSURL
    typealias JSONArrayCompletion = AnyObject?
    
    init(url: NSURL) {
        self.queryURL = url
    }
    
    func downloadJSONFromURL(completion: (JSONArrayCompletion -> Void)) {
        
        let request: NSURLRequest = NSURLRequest(URL: queryURL)
        let dataTask = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            (data, response, error) in
            
            if let httpResponse = response as? NSHTTPURLResponse, let urlContent = data {
                switch httpResponse.statusCode {
                case 200:
                    do {
                        let jsonArray = try NSJSONSerialization.JSONObjectWithData(urlContent, options: .MutableContainers)
                        completion(jsonArray)
                        
                    } catch {
                        
                    }
                default:
                    print("GET request not succesful. HTTP status code: \(httpResponse.statusCode)")
                }
                
            } else {
                print("Error: Not a valid HTTP response")
            }
        }
        dataTask.resume()
    }
}
