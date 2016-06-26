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
        let g = Giphy(apiKey: Giphy.PublicBetaAPIKey)
        
        g.random("\(feedItem.homeTeamName) football", rating: nil) { gif, err in
            
            if (gif != nil) {
                let gifUrlString = gif!.json["fixed_width_small_url"] as! String
                let gifURL = NSURL(string: gifUrlString);
                feedItem.gifImageURL = gifURL
            }
        }
    }
}
