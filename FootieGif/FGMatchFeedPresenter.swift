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
}
