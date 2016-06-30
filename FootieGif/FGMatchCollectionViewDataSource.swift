//
//  FGMatchCollectionViewDataSource.swift
//  FootieGif
//
//  Created by Rasheed Wihaib on 26/06/2016.
//  Copyright © 2016 fg. All rights reserved.
//

import UIKit

class FGMatchCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    var feedItems = [FGManagedMatch]()
    var favouriteItems = [FGManagedMatch]()
    var cache = [NSURL:NSData]()
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        if (favouriteItems.isEmpty) {
            
            return 1
        } else {
            return 2
        }
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        if (section == 0) {
            
            return self.favouriteItems.count;
        } else {
            return self.feedItems.count;
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("FGMatchCell", forIndexPath: indexPath) as! FGMatchCell
        
        var feedItem: FGManagedMatch
        
        if (indexPath.section == 0) {

            feedItem = self.favouriteItems[indexPath.row] as FGManagedMatch

        } else {
            
            feedItem = self.feedItems[indexPath.row] as FGManagedMatch
        }
        
        cell.textLabel.textColor = UIColor.darkGrayColor()
        cell.textLabel.text = feedItem.caption
        cell.imageView.image = nil;
                
        guard let gifImageData = feedItem.gifImageData else { return cell }
            
        cell.imageView.prepareForAnimation(imageData: gifImageData)
        cell.textLabel.textColor = UIColor.whiteColor()
        
        return cell
    }
    
    func feedItemAtIndexPath(indexPath: NSIndexPath) -> FGManagedMatch {
        
        return self.feedItems[indexPath.row]
    }
}
