//
//  FGMatchFeedDataProvider.swift
//  FootieGif
//
//  Created by Rasheed Wihaib on 26/06/2016.
//  Copyright © 2016 fg. All rights reserved.
//

import UIKit

class FGMatchFeedDataProvider: NSObject {

    func fetchFeed(completionHandler: ([FGManagedMatch]) -> Void) -> Void {
        
        let dataReporter = FGDataReporter()
        let allMatches = dataReporter.allMatches()
        
        if (allMatches.count > 0) {
            
            completionHandler(allMatches)
            return;
        }
        
        let networkRequest = FGNetworkRequest()
        
        guard let url = NSURL.init(string: "http://api.football-data.org/v1/soccerseasons/424/fixtures") else {

            return
        }
        
        let request = NSMutableURLRequest()
        request.URL = url;
        request.addValue("ae51e805afec4192bc0b58fdc3afa91e", forHTTPHeaderField: "X-Auth-Token")

        networkRequest.executeRequest(request) { (responseData, response, error) in
            
            if (responseData != nil) {
                
                do {
                    let dictionary = try NSJSONSerialization.JSONObjectWithData(responseData!, options: []) as! [String:AnyObject]
                    
                    let fixturesArray = dictionary["fixtures"] as! [[String:AnyObject]]
                    
                    let matches = self.matchesFromDictionaryArray(fixturesArray);

                    completionHandler(matches)
                    return
                } catch {
                    print("error: \(error)")
                }
                
            } else if (error != nil) {
                
            }
        }
    }
    
// private methods
    
    private func matchesFromDictionaryArray(array: [[String:AnyObject]]) -> [FGManagedMatch] {
        
        var matches = [FGManagedMatch]()

        for matchDictionary in array {
            
            let match = FGMatch.init(dictionary: matchDictionary)
            
            let dataAccessor = FGDataAccessor()
            let matchMO = dataAccessor.saveMatch(match)
            
            matches.append(matchMO)
        }
        
        do {
            try FGDataStore.sharedInstance.managedObjectContext.save()
            let dataReporter = FGDataReporter()
            matches = dataReporter.allMatches()
            return matches
            
        } catch let error {
            print("Could not cache the response \(error)")
        }

        return matches
    }

}
