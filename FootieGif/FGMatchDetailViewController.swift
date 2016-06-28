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
}
