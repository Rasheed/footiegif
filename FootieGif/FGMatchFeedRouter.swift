//
//  FGMatchFeedRouter.swift
//  FootieGif
//
//  Created by Rasheed Wihaib on 26/06/2016.
//  Copyright © 2016 fg. All rights reserved.
//

import UIKit

class FGMatchFeedRouter: NSObject {

    weak var viewController: FGMatchCollectionViewController!
    
    func presentMatchDetail(match: FGMatch) {
        
       let detailViewController = FGMatchDetailViewController()
//        self.viewController.presentViewController(detailViewController, animated: true, completion: nil)
    }
}
