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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let gifImageData = self.match?.gifImageData else { return }

        imageView.animateWithImageData(gifImageData)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    
    }
    
    @IBAction func didClickBackButton(sender: AnyObject) {
   
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func previewActionItems() -> [UIPreviewActionItem] {
        
        let likeAction = UIPreviewAction(title: "Like", style: .Default) { (action, viewController) -> Void in
            print("You liked the photo")
        }
        
        let deleteAction = UIPreviewAction(title: "Delete", style: .Destructive) { (action, viewController) -> Void in
            print("You deleted the photo")
        }
        
        return [likeAction, deleteAction]
        
    }

}
