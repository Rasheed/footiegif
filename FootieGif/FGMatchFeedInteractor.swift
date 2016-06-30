//
//  FGMatchFeedInteractor.swift
//  FootieGif
//
//  Created by Rasheed Wihaib on 26/06/2016.
//  Copyright © 2016 fg. All rights reserved.
//

import UIKit

class FGMatchFeedInteractor: NSObject {
    
    var output: FGMatchFeedPresenter!
    let dataProvider = FGMatchFeedDataProvider()
    var updatedIndexes = Set<NSIndexPath>()
    
    func fetchFeed() -> Void {
        
        self.dataProvider.fetchFeed{ (matches) in
                        
            let favouritePredicate = NSPredicate(format: "isFavourite = true")
            let favourites = (matches as NSArray).filteredArrayUsingPredicate(favouritePredicate) as! [FGManagedMatch]
            
            let nonFavouritePredicate = NSPredicate(format: "isFavourite != true")
            let nonFavourites = (matches as NSArray).filteredArrayUsingPredicate(nonFavouritePredicate) as! [FGManagedMatch]
            
            self.output.presentFeed(favourites, feedItems: nonFavourites)
        }
    }
        
    func updateMatchFeedItem(feedItem: FGManagedMatch, indexPath: NSIndexPath) {
        
        if (self.updatedIndexes.contains(indexPath)) {
            return;
        }
        self.updatedIndexes.insert(indexPath)
        
        if (feedItem.previewGifURLString.isEmpty) {
            
            self.updateGifUrls(feedItem, indexPath: indexPath)

        } else {
            
            self.updateGifData(feedItem, indexPath: indexPath)
        }
    }
    
    private func updateGifData(feedItem: FGManagedMatch, indexPath: NSIndexPath) {
        
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        dispatch_async(dispatch_get_global_queue(priority, 0)) {
            
            let networkRequest = FGNetworkRequest()
            let request = NSMutableURLRequest()
            request.URL = NSURL(string: feedItem.previewGifURLString);
            
            networkRequest.executeRequest(request) { (responseData, response, error) in
                
                if (responseData != nil) {
                    dispatch_async(dispatch_get_main_queue()) {
                        feedItem.gifImageData = responseData!
                        self.output.updateFeedItem(feedItem, indexPath: indexPath)
                    }
                }
            }
        }
    }
    
    private func updateGifUrls(feedItem: FGManagedMatch, indexPath: NSIndexPath) {
        
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        dispatch_async(dispatch_get_global_queue(priority, 0)) {
            
            let g = Giphy(apiKey: Giphy.PublicBetaAPIKey)
            
            g.random("\(feedItem.winningTeamName) football", rating: nil) { gif, err in
                
                if (gif != nil) {
                    
                    let previewGifUrlString = gif!.json["fixed_width_downsampled_url"] as! String
                    feedItem.previewGifURLString = previewGifUrlString
                    let gifUrlString = gif!.json["image_url"] as! String
                    feedItem.gifURLString = gifUrlString
                    
                    self.updateGifData(feedItem, indexPath: indexPath)
                }
                
            }
        }
        
    }
}
