//
//  FGMatchCollectionViewController.swift
//  FootieGif
//
//  Created by Rasheed Wihaib on 25/06/2016.
//  Copyright © 2016 fg. All rights reserved.
//

import UIKit

class FGMatchCollectionViewController: UICollectionViewController, UIViewControllerPreviewingDelegate {
    
    var dataSource: FGMatchCollectionViewDataSource
    var output: FGMatchFeedInteractor!
    var router: FGMatchFeedRouter!

    
    init() {
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 320, height: 200)
        self.dataSource = FGMatchCollectionViewDataSource()
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FGMatchFeedConfigurator.sharedInstance.configure(self)
        
        self.collectionView?.dataSource = self.dataSource;
        self.collectionView?.delegate = self;
        self.collectionView!.registerNib(UINib(nibName: "FGMatchCell", bundle: nil), forCellWithReuseIdentifier: "FGMatchCell")
        self.collectionView?.backgroundColor = UIColor.init(white:248/255.0, alpha: 1.0)
        self.output.fetchFeed()
        
        if( traitCollection.forceTouchCapability == .Available){
            
            registerForPreviewingWithDelegate(self, sourceView: self.collectionView!)
            
        }
    }
    
    override func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        
        self.output.updateMatchFeedItem(self.dataSource.feedItemAtIndexPath(indexPath), index:indexPath.row)
    }
    
    override func collectionView(collectionView: UICollectionView,moveItemAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        // move your data order
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let match = self.dataSource.feedItemAtIndexPath(indexPath)
        
        self.router.presentMatchDetail(match)
    }
    
    func previewingContext(previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        
        guard let indexPath = collectionView?.indexPathForItemAtPoint(location) else { return nil }
        guard let cell = collectionView?.cellForItemAtIndexPath(indexPath) else { return nil }

        let feedItem = self.dataSource.feedItemAtIndexPath(indexPath)
        
        let viewController = FGMatchDetailViewController()
        
        viewController.match = feedItem
        viewController.preferredContentSize = CGSize(width: 320, height: 200)
        
        previewingContext.sourceRect = cell.frame
        
        return viewController
    }
    
    func previewingContext(previewingContext: UIViewControllerPreviewing, commitViewController viewControllerToCommit: UIViewController) {
        
        showViewController(viewControllerToCommit, sender: self)
        
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
            matchCell.imageView.stopAnimatingGIF()
        }
    }    
}

