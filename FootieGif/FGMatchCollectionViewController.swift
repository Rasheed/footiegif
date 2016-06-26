//
//  FGMatchCollectionViewController.swift
//  FootieGif
//
//  Created by Rasheed Wihaib on 25/06/2016.
//  Copyright © 2016 fg. All rights reserved.
//

import UIKit

class FGMatchCollectionViewController: UICollectionViewController {
    
    init() {
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 300, height: 200)
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView?.dataSource = self;
        self.collectionView?.delegate = self;
        collectionView!.registerNib(UINib(nibName: "FGMatchCell", bundle: nil), forCellWithReuseIdentifier: "FGMatchCell")
    }
    
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("FGMatchCell", forIndexPath: indexPath) as! FGMatchCell
        
        let url = NSURL.init(string: "https://media.giphy.com/media/6HZWMDaqPLdq8/giphy.gif")!
        let request = NSURLRequest(URL: url)
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: config)
        
        let task = session.dataTaskWithRequest(request, completionHandler: {(data, response, error) in
            
            dispatch_async(dispatch_get_main_queue(), {
                
                if (data != nil) {
                    cell.imageView.prepareForAnimation(imageData: data!)
                } else if (error != nil) {
                    //handle error
                }
            });
            
        });
        
        task.resume()
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView,moveItemAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        // move your data order
    }
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        
        let visibleCells = self.collectionView?.visibleCells()
        for visibleCell in visibleCells! {
            
            let matchCell = visibleCell as! FGMatchCell
            if (!matchCell.imageView.isAnimatingGIF) {
            matchCell.imageView.startAnimatingGIF()
            }
        }
    }
    
    override func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
    
        let visibleCells = self.collectionView?.visibleCells()
        for visibleCell in visibleCells! {
            
            let matchCell = visibleCell as! FGMatchCell
            if (matchCell.imageView.isAnimatingGIF) {
                matchCell.imageView.stopAnimatingGIF()
            }
        }
    }
}

