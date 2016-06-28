//
//  FGMatchFeedRouter.swift
//  FootieGif
//
//  Created by Rasheed Wihaib on 26/06/2016.
//  Copyright © 2016 fg. All rights reserved.
//

import UIKit

class FGMatchFeedRouter: NSObject, UIViewControllerTransitioningDelegate {
    
    weak var viewController: FGMatchCollectionViewController!
    let customPresentAnimationController = FGCustomMatchPresenterAnimator()
    let customDismissAnimationController = FGCustomMatchDismissAnimator()
    
    func presentMatchDetail(match: FGMatch) {
        
        let detailViewController = FGMatchDetailViewController()
        detailViewController.match = match
        detailViewController.transitioningDelegate = self
        self.viewController.presentViewController(detailViewController, animated: true, completion: nil)
    }
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return customPresentAnimationController
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return customDismissAnimationController
    }
    
}
