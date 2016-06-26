//
//  FGMatchCell.swift
//  FootieGif
//
//  Created by Rasheed Wihaib on 25/06/2016.
//  Copyright © 2016 fg. All rights reserved.
//

import UIKit
import Gifu

class FGMatchCell: UICollectionViewCell {

    @IBOutlet var textLabel: UILabel!
    @IBOutlet var imageView: AnimatableImageView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
