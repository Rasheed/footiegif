//
//  FGMatch.swift
//  FootieGif
//
//  Created by Rasheed Wihaib on 26/06/2016.
//  Copyright © 2016 fg. All rights reserved.
//

import UIKit

class FGMatch: NSObject {
    
    var caption: String {
        
        get {
            
            let homeTeamName = self.dictionary["homeTeamName"] as! String
            let awayTeamName = self.dictionary["awayTeamName"] as! String
            
            let status = self.dictionary["status"] as! String
            if (status == "FINISHED") {
                
                let result = self.dictionary["result"] as! [String:AnyObject]
                let goalsHomeTeam = result["goalsHomeTeam"] as! Int
                let goalsAwayTeam = result["goalsAwayTeam"] as! Int
                
                return "\(homeTeamName) \(goalsHomeTeam) - \(goalsAwayTeam) \(awayTeamName)"
                
            } else {
                
                return "\(homeTeamName) - \(awayTeamName)"
            }
        }
    }
    
    var gifImageData: NSData?
    
    var furtherDetailURL: NSURL = NSURL()
    var homeTeamURL: NSURL = NSURL()
    var awayTeamURL:NSURL = NSURL()
    var homeTeamColor = UIColor()
    var awayTeamColor = UIColor()
    
    private var dictionary: [String:AnyObject]
    
    init(dictionary: [String:AnyObject]) {
        
        self.dictionary = dictionary;
        super.init()
    }
    
    
}
