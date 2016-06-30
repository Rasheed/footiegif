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
    
    func presentFeed(favouriteItems:[FGManagedMatch], feedItems: [FGManagedMatch]) -> Void {
        
        self.output.dataSource.favouriteItems = favouriteItems
        self.output.dataSource.feedItems = feedItems
        self.output.collectionView?.reloadData()
    }
    
    func updateFeedItem(feedItem: FGManagedMatch, indexPath: NSIndexPath) -> Void {

        dispatch_async(dispatch_get_main_queue()) {
            
//            self.output.collectionView?.numberOfItemsInSection(0)
//            if ((self.output.collectionView?.dataSource!.numberOfSectionsInCollectionView!(self.output.collectionView!))! == 2) {
//                self.output.collectionView?.numberOfItemsInSection(1)
//            }
//            self.output.collectionView?.reloadItemsAtIndexPaths([indexPath]);
            
            self.output.collectionView?.reloadData()
        }
        
    }
}
