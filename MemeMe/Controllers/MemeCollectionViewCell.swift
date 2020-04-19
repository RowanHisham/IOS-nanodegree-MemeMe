//
//  MemeCollectionViewCell.swift
//  MemeMe
//
//  Created by Rowan Hisham on 4/19/20.
//  Copyright © 2020 Rowan Hisham. All rights reserved.
//

import UIKit

class MemeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var memeImageView: UIImageView! = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
}
