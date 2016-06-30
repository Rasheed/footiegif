//
//  FGManagedMatch.swift
//  FootieGif
//
//  Created by Rasheed Wihaib on 30/06/2016.
//  Copyright © 2016 fg. All rights reserved.
//

import UIKit
import CoreData

class FGManagedMatch: NSManagedObject {

    @NSManaged var goalsAwayTeam : Int
    @NSManaged var goalsHomeTeam : Int
    @NSManaged var homeTeamName : String
    @NSManaged var awayTeamName : String
    @NSManaged var gifImageUrlString : String

}
