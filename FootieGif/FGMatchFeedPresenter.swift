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
    
    func presentFeed(feedItems: [FGMatch]) -> Void {
        
        self.output.dataSource.feedItems = feedItems
        self.output.collectionView?.reloadData()
    }
    
    func updateFeedItem(feedItem: FGMatch, index: Int) -> Void {

        feedItem.gifImageURL = NSURL.init(string:"https://media.giphy.com/media/Lf8hahDExPYm4/giphy.gif")
    }
}
