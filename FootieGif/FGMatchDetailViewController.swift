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

    var match: FGManagedMatch?
    
    @IBOutlet var actionTextLabel: UILabel!
    @IBOutlet var textLabel: UILabel!
    @IBOutlet private var imageView: AnimatableImageView!
    @IBOutlet private var backgroundImageView: UIImageView!
    
    var output: FGMatchDetailInteractor!
    var router: FGMatchDetailRouter!
    private var configurator = FGMatchDetailConfigurator()
    
    var animator: UIDynamicAnimator!
    var attachmentBehavior : UIAttachmentBehavior!
    var snapBehavior : UISnapBehavior!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.configurator.configure(self)
        self.output.match = match
        
        self.actionTextLabel.alpha = 0.0
        self.textLabel.text =  (self.match?.winningTeamName)! + " Gifs"
        
        self.animator = UIDynamicAnimator(referenceView: self.view)
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(FGMatchDetailViewController.panImageView(_:)))
        panGestureRecognizer.minimumNumberOfTouches = 1
        self.imageView.userInteractionEnabled = true
        self.imageView.addGestureRecognizer(panGestureRecognizer)
        
        guard let gifImageData = self.match?.gifImageData else { return }
        
        self.updateDetailGif(gifImageData);
        let gif = FGGif()
        gif.previewGifURL = NSURL(string:(self.match?.previewGifURLString)!)
        gif.gifURL = NSURL(string:(self.match?.gifURLString)!)
        
        self.output.setCurrentGif(gif)
        
        guard let gifImage = UIImage(data: gifImageData) else { return }

        self.setBackgroundImage(gifImage)
    }
    
    func updateDetailGif(gifData:NSData!) {
        
        self.imageView.animateWithImageData(gifData)
    }
    
    func setBackgroundImage(image: UIImage) {
        
        self.backgroundImageView.image = image;
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
            self.output.imageViewMoved(sender.translationInView(view))
        }
        else if sender.state == UIGestureRecognizerState.Ended {
           
            animator.removeAllBehaviors()
            
            snapBehavior = UISnapBehavior(item: self.imageView, snapToPoint: view.center)
            animator.addBehavior(snapBehavior)
            self.imageView.alpha = 1.0;
            self.actionTextLabel.alpha = 0.0;
            
            if sender.translationInView(view).y < -200 {
                
                self.output.swipeUp()
                
            } else if sender.translationInView(view).y > 250 {

                self.output.swipeDown()
                
            } else if sender.translationInView(view).x > 100 {
                
                self.output.swipeRight()
            } else if sender.translationInView(view).x < -100 {
                
                self.output.swipeLeft()
            }
        }
    }
    
    func updateImageView(alpha: CGFloat, title: String) -> Void {

        self.imageView.alpha = alpha;
        self.actionTextLabel.center = self.imageView.center
        self.actionTextLabel.text = title
        self.actionTextLabel.alpha = 1.0
    }
    
    func removeImageView() -> Void {
        
        animator.removeAllBehaviors()
        
        let gravityBehaviour: UIGravityBehavior = UIGravityBehavior(items: [self.imageView])
        gravityBehaviour.gravityDirection = CGVectorMake(0.0, 10.0);
        animator.addBehavior(gravityBehaviour)
        
        let itemBehaviour: UIDynamicItemBehavior = UIDynamicItemBehavior(items: [self.imageView])
        itemBehaviour.addAngularVelocity(CGFloat(-M_PI_2), forItem: self.imageView)
        animator.addBehavior(itemBehaviour)
        
        UIView.animateWithDuration(0.4, animations: {
            self.self.imageView.alpha = 0.0
            }, completion: {
                (value: Bool) in

                self.dismissViewControllerAnimated(true, completion: nil)
        })
    }
    
    override func previewActionItems() -> [UIPreviewActionItem] {
        
        let likeAction = UIPreviewAction(title: "Save", style: .Default) { (action, viewController) -> Void in
            print("You liked the photo")
        }
        
        return [likeAction]
        
    }

}
