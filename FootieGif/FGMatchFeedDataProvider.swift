//
//  FGMatchFeedDataProvider.swift
//  FootieGif
//
//  Created by Rasheed Wihaib on 26/06/2016.
//  Copyright © 2016 fg. All rights reserved.
//

import UIKit

class FGMatchFeedDataProvider: NSObject {

    
    func fetchFeed(completionHandler: ([FGMatch]) -> Void) -> Void {
        
        let networkRequest = FGNetworkRequest()
        networkRequest.executeRequest(NSURL.init(string: "http://api.football-data.org/v1/soccerseasons/424/fixtures")) { (responseData, response, error) in
            
            if (responseData != nil) {
                
                do {
                    let dictionary = try NSJSONSerialization.JSONObjectWithData(responseData!, options: []) as! [String:AnyObject]
                    
                    let fixturesArray = dictionary["fixtures"] as! [[String:AnyObject]]
                    
                    let matches = self.matchesFromDictionaryArray(fixturesArray);
                    
                    completionHandler(matches)                    
                } catch {
                    print("error: \(error)")
                }
                
            } else if (error != nil) {
                
            }
        }
    }
    
    func fetchImageForFeedItem(feedItem: FGMatch, completionHandler: (NSData) -> Void) {
        
        let networkRequest = FGNetworkRequest()
        networkRequest.executeRequest(NSURL.init(string:"http://i.giphy.com/xT0GquVx2okVvSekqk.gif")) { (responseData, response, error) in
            
            if (responseData != nil) {
                
                completionHandler(responseData!)
            } else if (error != nil) {
                
            }
        }

    }
    
// private methods
    
    private func matchesFromDictionaryArray(array: [[String:AnyObject]]) -> [FGMatch] {
        
        var matches = [FGMatch]()

        for matchDictionary in array {
            
            let match = FGMatch.init(dictionary: matchDictionary)
            matches.append(match)
        }
        return matches
    }

}
