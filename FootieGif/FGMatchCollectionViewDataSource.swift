//
//  FGMatchCollectionViewDataSource.swift
//  FootieGif
//
//  Created by Rasheed Wihaib on 26/06/2016.
//  Copyright © 2016 fg. All rights reserved.
//

import UIKit

class FGMatchCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    var feedItems = [FGMatch]()
    var cache = [NSURL:NSData]()
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return self.feedItems.count;
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("FGMatchCell", forIndexPath: indexPath) as! FGMatchCell
        
        let feedItem = feedItems[indexPath.row] as FGMatch
        cell.textLabel.text = feedItem.caption
        cell.textLabel.textColor = UIColor.darkGrayColor()
        cell.imageView.image = nil;
        
        guard let gifImageData = feedItem.gifImageData else { return cell }
            
        cell.imageView.prepareForAnimation(imageData: gifImageData)
        cell.textLabel.textColor = UIColor.whiteColor()
        
        return cell
    }
    
    func feedItemAtIndexPath(indexPath: NSIndexPath) -> FGMatch {
        
        return self.feedItems[indexPath.row]
    }
}
