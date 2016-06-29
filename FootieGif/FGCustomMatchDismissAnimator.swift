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
        
        let snapshotView = fromViewController.imageView
        snapshotView.frame = CGRectMake(100, 100, 300, 250)
        containerView!.addSubview(snapshotView)
        
        fromViewController.view.removeFromSuperview()
        
        UIView.animateWithDuration(transitionDuration(transitionContext), animations: {
            
            snapshotView.frame = CGRectMake(100, 100, 300, 0)
            toViewController.view.alpha = 1.0
            
            }, completion: {
                finished in
                
                snapshotView.removeFromSuperview()
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
        })
    }
}