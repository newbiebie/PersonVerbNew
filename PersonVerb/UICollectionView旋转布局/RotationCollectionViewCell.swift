//
//  RotationCollectionViewCell.swift
//  PersonVerb
//
//  Created by GongHua Guo on 2018/1/17.
//  Copyright © 2018年 GongHua Guo. All rights reserved.
//

import UIKit

class RotationCollectionViewCell: AginCollectionViewCell {
    
    var imageView : UIImageView?
    
    
    override func setUI() {
        super.setUI()
        self.imageView = UIImageView.init(frame: self.contentView.bounds)
        self.imageView?.layer.cornerRadius = 10
        self.imageView?.layer.masksToBounds = true
        self.imageView?.isUserInteractionEnabled = true
        self.contentView.addSubview(self.imageView!)
        self.contentView.bringSubview(toFront: self.label!)
        self.label?.backgroundColor = .clear
        self.label?.textColor = .red
        self.label?.font = UIFont.boldSystemFont(ofSize: 25.0)
    }
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        let circularlayoutAttributes = layoutAttributes as! RotationCollectionViewLayoutAttributes
        self.layer.anchorPoint = circularlayoutAttributes.anchorPoint
        self.center.y += (circularlayoutAttributes.anchorPoint.y - 0.5) * self.bounds.size.height
    }
}
