//
//  VCViewCell.swift
//  PersonVerb
//
//  Created by GongHua Guo on 2018/9/10.
//  Copyright © 2018年 GongHua Guo. All rights reserved.
//

import UIKit

class VCViewCell: UICollectionViewCell {

    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.contentView.layer.cornerRadius = 5
        self.iconImage.layer.cornerRadius = 8
        self.iconImage.layer.masksToBounds = true
    }

}
