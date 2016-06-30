//
//  FGDataAccessor.swift
//  FootieGif
//
//  Created by Rasheed Wihaib on 30/06/2016.
//  Copyright © 2016 fg. All rights reserved.
//

import UIKit
import CoreData

class FGDataAccessor: NSObject {

    func saveMatch(match: FGMatch) {
        
        let entity =  NSEntityDescription.entityForName("FGManagedMatch", inManagedObjectContext:FGDataStore.sharedInstance.managedObjectContext)
        
        let matchMO = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: FGDataStore.sharedInstance.managedObjectContext) as! FGManagedMatch
        
        matchMO.homeTeamName = match.homeTeamName
        matchMO.awayTeamName = match.awayTeamName
        matchMO.goalsAwayTeam = match.goalAwayTeam
        matchMO.goalsHomeTeam = match.goalHomeTeam
    }
}
