//
//  FGCustomMatchPresenterAnimator.swift
//  FootieGif
//
//  Created by Rasheed Wihaib on 28/06/2016.
//  Copyright © 2016 fg. All rights reserved.
//

import UIKit

class FGCustomMatchPresenterAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.5
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        let finalFrameForVC = transitionContext.finalFrameForViewController(toViewController)
        let containerView = transitionContext.containerView()

        containerView!.addSubview(toViewController.view)
        toViewController.view.alpha = 0.0;
        
        UIView.animateWithDuration(transitionDuration(transitionContext), animations: { 
            
            toViewController.view.alpha = 1.0;
            toViewController.view.frame = finalFrameForVC;

            }) { (finished) in
                
                transitionContext.completeTransition(finished)

        }
    }
    
}