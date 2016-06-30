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
    var updatedIndexes = Set<Int>()
    
    func fetchFeed() -> Void {
        
        self.dataProvider.fetchFeed{ (matches) in
            
            self.output.presentFeed(matches)
        }
    }
        
    func updateMatchFeedItem(feedItem: FGMatch, index: Int) {
        
        if (self.updatedIndexes.contains(index)) {
            return;
        }
        self.updatedIndexes.insert(index)
        
        if (feedItem.previewGifUrl != nil) {
            
            self.updateGifData(feedItem, index: index)
        } else {
            
            self.updateGifUrl(feedItem, index: index)
        }
        
    }
    
    private func updateGifData(feedItem: FGMatch, index: Int) {
        
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        dispatch_async(dispatch_get_global_queue(priority, 0)) {
            
            let networkRequest = FGNetworkRequest()
            networkRequest.executeRequest(feedItem.previewGifUrl) { (responseData, response, error) in
                
                if (responseData != nil) {
                    dispatch_async(dispatch_get_main_queue()) {
                        feedItem.gifImageData = responseData!
                        self.output.updateFeedItem(feedItem, index: index)
                    }
                }
            }
        }
    }
    
    private func updateGifUrl(feedItem: FGMatch, index: Int) {
        
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        dispatch_async(dispatch_get_global_queue(priority, 0)) {
            
            let g = Giphy(apiKey: Giphy.PublicBetaAPIKey)
            
            g.random("\(feedItem.winningTeamName) football", rating: nil) { gif, err in
                //fixed_width_downsampled_url
                
                if (gif != nil) {
                    
                    let gifUrlString = gif!.json["image_url"] as! String
                    let gifURL = NSURL(string: gifUrlString);
                    feedItem.gifImageURL = gifURL
                    let previewGifUrlString = gif!.json["fixed_width_small_url"] as! String
                    let previewGifUrl = NSURL(string: previewGifUrlString);
                    feedItem.previewGifUrl = previewGifUrl
                    self.updateGifData(feedItem, index: index)
                    
                }
                
            }
        }
        
    }
}
