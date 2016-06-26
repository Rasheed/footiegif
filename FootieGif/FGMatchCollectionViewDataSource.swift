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
        
        if (feedItem.gifImageURL != nil) {
            
            let networkRequest = FGNetworkRequest()
            networkRequest.executeRequest(feedItem.gifImageURL!) { (responseData, response, error) in
                
                if (responseData != nil) {
                    
                    cell.imageView.animateWithImageData(responseData!)
                } else if (error != nil) {
                    
                }
            }
        }

        return cell
    }
    
    func feedItemAtIndexPath(indexPath: NSIndexPath) -> FGMatch {
        
        return self.feedItems[indexPath.row]
    }
}
