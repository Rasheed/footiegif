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

    func allMatches() -> [FGManagedMatch] {
        
        let fetchRequest = NSFetchRequest(entityName: "FGManagedMatch")
        var matches: [FGManagedMatch] = []
        
        do {
            let results = try FGDataStore.sharedInstance.managedObjectContext.executeFetchRequest(fetchRequest)
            matches = results as! [FGManagedMatch]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
        return matches
    }
}
