//
//  FGDataReporter.swift
//  FootieGif
//
//  Created by Rasheed Wihaib on 30/06/2016.
//  Copyright © 2016 fg. All rights reserved.
//

import UIKit
import CoreData

class FGDataReporter: NSObject {

    func allMatches() -> [NSManagedObject] {
        
        let fetchRequest = NSFetchRequest(entityName: "Match")
        var matches: [NSManagedObject] = []
        
        do {
            let results = try FGDataStore.sharedInstance.managedObjectContext.executeFetchRequest(fetchRequest)
            matches = results as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
        return matches
    }
}
