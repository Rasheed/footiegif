//
//  FGMatchDetailPresenter.swift
//  FootieGif
//
//  Created by Rasheed Wihaib on 29/06/2016.
//  Copyright © 2016 fg. All rights reserved.
//

import UIKit

class FGMatchDetailPresenter: NSObject {

    weak var output: FGMatchDetailViewController!

    func updateImageViewGif(gifData: NSData!) -> Void {
        
        if (self.output != nil) {
            
            self.output.imageView.animateWithImageData(gifData)
        }
    }
    
    func updateBackgroundImageData(imageData: NSData!) -> Void {
        
        UIView.transitionWithView(self.output.imageView, duration:0.5, options: UIViewAnimationOptions.TransitionCrossDissolve, animations:{
            self.output.backgroundImageView.image = UIImage(data: imageData!);
        },completion: nil)
    }
    
    func presentShareActivity(shareItems: [AnyObject]) {
        
        let activityViewController:UIActivityViewController = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)
        activityViewController.excludedActivityTypes = [UIActivityTypePrint, UIActivityTypePostToWeibo, UIActivityTypeCopyToPasteboard, UIActivityTypeAddToReadingList, UIActivityTypePostToVimeo]

        self.output.presentViewController(activityViewController, animated: true, completion: nil)
    }
}
