//
//  FGMatchFeedPresenter.swift
//  FootieGif
//
//  Created by Rasheed Wihaib on 26/06/2016.
//  Copyright © 2016 fg. All rights reserved.
//

import UIKit

class FGMatchFeedPresenter: NSObject {

    weak var output: FGMatchCollectionViewController!
    
    func presentFeed(feedItems: [FGManagedMatch]) -> Void {
        
        self.output.dataSource.feedItems = feedItems
        self.output.collectionView?.reloadData()
    }
    
    func updateFeedItem(feedItem: FGManagedMatch, index: Int) -> Void {

        let indexPath = NSIndexPath(forRow: index, inSection: 0)
        dispatch_async(dispatch_get_main_queue()) { 
            
            self.output.collectionView?.numberOfItemsInSection(0)
            self.output.collectionView?.reloadItemsAtIndexPaths([indexPath]);
        }
        
    }
}
