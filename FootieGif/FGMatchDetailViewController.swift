//
//  FGMatchDetailViewController.swift
//  FootieGif
//
//  Created by Rasheed Wihaib on 27/06/2016.
//  Copyright © 2016 fg. All rights reserved.
//

import UIKit
import Gifu

class FGMatchDetailViewController: UIViewController {

    var match: FGMatch?
    
    @IBOutlet var imageView: AnimatableImageView!
    @IBOutlet var backgroundImageView: AnimatableImageView!
    
    var animator: UIDynamicAnimator!
    var attachmentBehavior : UIAttachmentBehavior!
    var snapBehavior : UISnapBehavior!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.animator = UIDynamicAnimator(referenceView: view)
        
        guard let gifImageData = self.match?.gifImageData else { return }

        self.imageView.animateWithImageData(gifImageData)
        self.backgroundImageView.image = UIImage(data: gifImageData)
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(FGMatchDetailViewController.panImageView(_:)))
        panGestureRecognizer.minimumNumberOfTouches = 1
        self.imageView.userInteractionEnabled = true
        self.imageView.addGestureRecognizer(panGestureRecognizer)
        
        let networkRequest = FGNetworkRequest()
        networkRequest.executeRequest(match?.gifImageURL) { (responseData, response, error) in
            
            if (responseData != nil) {
                dispatch_async(dispatch_get_main_queue()) {
                    self.match!.gifImageData = responseData!
                    self.imageView.animateWithImageData(responseData!)
                }
                
            }
        }
    }
    
    func panImageView(sender: UIPanGestureRecognizer) {
        
        let panLocationInView = sender.locationInView(view)
        let panLocationInImageView = sender.locationInView(self.imageView)
        
        if sender.state == UIGestureRecognizerState.Began {
            self.animator.removeAllBehaviors()
            
            let offset = UIOffsetMake(panLocationInImageView.x - CGRectGetMidX(self.imageView.bounds), panLocationInImageView.y - CGRectGetMidY(self.imageView.bounds));
            attachmentBehavior = UIAttachmentBehavior(item: self.imageView, offsetFromCenter: offset, attachedToAnchor: panLocationInView)
            
            animator.addBehavior(attachmentBehavior)
        }
        else if sender.state == UIGestureRecognizerState.Changed {
            attachmentBehavior.anchorPoint = panLocationInView
        }
        else if sender.state == UIGestureRecognizerState.Ended {
            animator.removeAllBehaviors()
            
            snapBehavior = UISnapBehavior(item: self.imageView, snapToPoint: view.center)
            animator.addBehavior(snapBehavior)
            
            if sender.translationInView(view).y > 100 {

                self.dismissViewControllerAnimated(true, completion: nil)
            }
            if sender.translationInView(view).x > 100 || sender.translationInView(view).x < -100{
                
                print("Load next image")
            }

        }
    }
        
    override func previewActionItems() -> [UIPreviewActionItem] {
        
        let likeAction = UIPreviewAction(title: "Share", style: .Default) { (action, viewController) -> Void in
            print("You liked the photo")
        }
        
        let deleteAction = UIPreviewAction(title: "Save", style: .Destructive) { (action, viewController) -> Void in
            print("You deleted the photo")
        }
        
        return [likeAction, deleteAction]
        
    }

}
