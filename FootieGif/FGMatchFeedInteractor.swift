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
    
    func fetchFeed() -> Void {
        
        self.dataProvider.fetchFeed{ (matches) in
            
            self.output.presentFeed(matches)
        }
    }
    
    func updateMatchFeedItem(feedItem: FGMatch, index: Int) -> Void {
        
        self.output.updateFeedItem(feedItem, index: index)

//        self.dataProvider.fetchImageForFeedItem(feedItem) { (imageData) in
//            
//        }
    }
}
