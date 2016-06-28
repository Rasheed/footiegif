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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let gifImageData = self.match?.gifImageData else { return }

        self.imageView.animateWithImageData(gifImageData)
        self.backgroundImageView.image = UIImage(data: gifImageData)
        
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
    
    @IBAction func didClickBackButton(sender: AnyObject) {
   
        self.dismissViewControllerAnimated(true, completion: nil)
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
