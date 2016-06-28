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
    
    func updateMatchFeedItem(feedItem: FGMatch, index: Int) -> Void {
        
        if (updatedIndexes.contains(index)) {
            return;
        }
        updatedIndexes.insert(index)
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        dispatch_async(dispatch_get_global_queue(priority, 0)) {
            
            let g = Giphy(apiKey: Giphy.PublicBetaAPIKey)
            
            g.random("\(feedItem.winningTeamName) soccer", rating: nil) { gif, err in
                //fixed_width_downsampled_url
                if (gif != nil) {
                    let gifUrlString = gif!.json["fixed_width_downsampled_url"] as! String
                    let gifURL = NSURL(string: gifUrlString);
                    feedItem.gifImageURL = gifURL
                    
                    let networkRequest = FGNetworkRequest()
                    networkRequest.executeRequest(gifURL) { (responseData, response, error) in
                        
                        if (responseData != nil) {
                            dispatch_async(dispatch_get_main_queue()) {
                                feedItem.gifImageData = responseData!
                                self.output.updateFeedItem(feedItem, index: index)
                            }
                            
                        }
                        
                    }
                }
                
            }
            
        }
    }
}
