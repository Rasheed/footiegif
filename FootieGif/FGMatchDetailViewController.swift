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
    
    @IBOutlet var actionTextLabel: UILabel!
    @IBOutlet var textLabel: UILabel!
    @IBOutlet var imageView: AnimatableImageView!
    @IBOutlet var backgroundImageView: AnimatableImageView!
    
    var output: FGMatchDetailInteractor!
    var router: FGMatchDetailRouter!
    private var configurator = FGMatchDetailConfigurator()
    
    var animator: UIDynamicAnimator!
    var attachmentBehavior : UIAttachmentBehavior!
    var snapBehavior : UISnapBehavior!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configurator.configure(self)

        self.actionTextLabel.alpha = 0.0
        self.textLabel.text =  (self.match?.winningTeamName)! + " Gifs"
        
        self.animator = UIDynamicAnimator(referenceView: view)
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(FGMatchDetailViewController.panImageView(_:)))
        panGestureRecognizer.minimumNumberOfTouches = 1
        self.imageView.userInteractionEnabled = true
        self.imageView.addGestureRecognizer(panGestureRecognizer)
        
        guard let gifImageData = self.match?.gifImageData else { return }
        
        let gif = FGGif()
        gif.previewGifURL = self.match?.previewGifUrl
        gif.gifURL = self.match?.gifImageURL
        
        self.output.setCurrentGif(gif)
        
        self.imageView.animateWithImageData(gifImageData)
        self.imageView.layer.shadowColor = UIColor.blackColor().CGColor;
        self.imageView.layer.shadowOffset = CGSizeMake(0, 5);
        self.imageView.layer.shadowOpacity = 0.3;
        self.imageView.layer.shadowRadius = 10.0;
        
        self.backgroundImageView.image = UIImage(data: gifImageData)
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
            
            self.actionTextLabel.center = self.imageView.center
            
            if sender.translationInView(view).y < -200 {
                
                self.actionTextLabel.alpha = 1;
                self.actionTextLabel.text = "Share"
            } else if sender.translationInView(view).y > 50.0 {

                let alpha = 1.0 - sender.translationInView(view).y / 400.0;
                self.imageView.alpha = alpha;
                self.actionTextLabel.text = "Bye"
                self.actionTextLabel.alpha = 1 - alpha;
                
            } else if sender.translationInView(view).x > 100 {
                
                self.actionTextLabel.alpha = 1;
                self.actionTextLabel.text = "Next"

            } else if sender.translationInView(view).x < -100 {
                
                self.actionTextLabel.alpha = 1;
                self.actionTextLabel.text = "Previous"
            } else {
                
                self.actionTextLabel.alpha = 0.0;
                self.imageView.alpha = 1.0;
            }
        }
        else if sender.state == UIGestureRecognizerState.Ended {
            animator.removeAllBehaviors()
            
            snapBehavior = UISnapBehavior(item: self.imageView, snapToPoint: view.center)
            animator.addBehavior(snapBehavior)
            self.imageView.alpha = 1.0;
            self.actionTextLabel.alpha = 0.0;
            
            if sender.translationInView(view).y < -200 {
                
                self.output.shareCurrentGif()
                
            } else if sender.translationInView(view).y > 250 {

                self.removeImageView()
                
            } else if sender.translationInView(view).x > 100 {
                
                self.output.nextGif((self.match?.winningTeamName)! + " football")
            } else if sender.translationInView(view).x < -100 {
                
                self.output.previousGif()
            }
        }
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
//                self.imageView.removeFromSuperview()
                self.dismissViewControllerAnimated(true, completion: nil)
        })
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
