//
//  FGCustomMatchDismissAnimator.swift
//  FootieGif
//
//  Created by Rasheed Wihaib on 28/06/2016.
//  Copyright © 2016 fg. All rights reserved.
//

import UIKit

class FGCustomMatchDismissAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.5
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)! as! FGMatchDetailViewController
        let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)! as! FGMatchCollectionViewController
        let finalFrameForVC = transitionContext.finalFrameForViewController(toViewController)
        let containerView = transitionContext.containerView()
        
        toViewController.view.frame = finalFrameForVC
        toViewController.view.alpha = 0.5
        containerView!.addSubview(toViewController.view)
        containerView!.sendSubviewToBack(toViewController.view)
        
        fromViewController.view.removeFromSuperview()
        
        UIView.animateWithDuration(transitionDuration(transitionContext), animations: {
            
            toViewController.view.alpha = 1.0
            
            }, completion: {
                finished in
                
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
        })
    }
}