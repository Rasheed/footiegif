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
        
        guard self.output != nil else { return }
        self.output.updateDetailGif(gifData)
    }
    
    func updateImageView(alpha: CGFloat, title: String) -> Void {
        
        self.output.updateImageView(alpha, title: title)
    }
    
    func updateBackgroundImageData(imageData: NSData!) -> Void {
        
        guard self.output != nil else { return }
        
        UIView.transitionWithView(self.output.view, duration:0.5, options: UIViewAnimationOptions.TransitionCrossDissolve, animations:{
            self.output.setBackgroundImage(UIImage(data: imageData!)!);
        },completion: nil)
    }
    
    func presentShareActivity(shareItems: [AnyObject]) {
        
        let activityViewController:UIActivityViewController = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)
        activityViewController.excludedActivityTypes = [UIActivityTypePrint, UIActivityTypePostToWeibo, UIActivityTypeCopyToPasteboard, UIActivityTypeAddToReadingList, UIActivityTypePostToVimeo]

        self.output.presentViewController(activityViewController, animated: true, completion: nil)
    }
}
