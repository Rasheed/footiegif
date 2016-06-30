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
    
    var goalHomeTeam: Int {
        
        let status = self.dictionary["status"] as! String
        var goalsHomeTeam = 0
        if (status == "FINISHED") {
            
            let result = self.dictionary["result"] as! [String:AnyObject]
            goalsHomeTeam = result["goalsHomeTeam"] as! Int
        }
        return goalsHomeTeam;
    }
    
    var goalAwayTeam: Int {
        
        let status = self.dictionary["status"] as! String
        var goalAwayTeam = 0
        if (status == "FINISHED") {
            
            let result = self.dictionary["result"] as! [String:AnyObject]
            goalAwayTeam = result["goalsAwayTeam"] as! Int
        }
        return goalAwayTeam;
    }

    
    
    var homeTeamName: String {
        
        get {
            let homeTeamName = self.dictionary["homeTeamName"] as! String
            return homeTeamName;
        }
    }
    
    var awayTeamName: String {
        
        get {
            let awayTeamName = self.dictionary["awayTeamName"] as! String
            return awayTeamName;
        }
    }
    
    var winningTeamName: String {
        
        get {
            
            let homeTeamName = self.dictionary["homeTeamName"] as! String
            let awayTeamName = self.dictionary["awayTeamName"] as! String
            
            let status = self.dictionary["status"] as! String
            if (status == "FINISHED") {
                
                let result = self.dictionary["result"] as! [String:AnyObject]
                let goalsHomeTeam = result["goalsHomeTeam"] as! Int
                let goalsAwayTeam = result["goalsAwayTeam"] as! Int
                
                if goalsHomeTeam > goalsAwayTeam {
                    return homeTeamName
                } else {
                    return awayTeamName
                }
            }
            return homeTeamName
        }
    }
    
    var gifImageData: NSData?
    var gifImageURL: NSURL?
    var previewGifUrl: NSURL?
    
    private var dictionary: [String:AnyObject]
    
    init(dictionary: [String:AnyObject]) {
        
        self.dictionary = dictionary;
        super.init()
    }
    
    
}
