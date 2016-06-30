//
//  FGNetworkRequest.swift
//  FootieGif
//
//  Created by Rasheed Wihaib on 25/06/2016.
//  Copyright © 2016 fg. All rights reserved.
//

import UIKit

class FGNetworkRequest: NSObject {

    func executeRequest(request: NSURLRequest!, completionHandler: (NSData?, NSURLResponse?, NSError?) -> Void) -> Void {

        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: config)
        
        let task = session.dataTaskWithRequest(request, completionHandler: {(data, response, error) in
            
            dispatch_async(dispatch_get_main_queue(), {
                
                if (data != nil) {
                    
                    completionHandler(data, response, error)
                    
                } else if (error != nil) {
                    
                    completionHandler(nil, response, error)
                }
            });
            
        });
        task.resume()
    }
}
