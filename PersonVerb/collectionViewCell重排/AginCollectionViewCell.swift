//
//  AginCollectionViewCell.swift
//  PersonVerb
//
//  Created by GongHua Guo on 2018/1/15.
//  Copyright © 2018年 GongHua Guo. All rights reserved.
//

import UIKit

class AginCollectionViewCell: UICollectionViewCell {
    
    //标题控件
    var label : UILabel?
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setUI() {
        self.label = UILabel.init(frame: self.contentView.bounds)
        self.label?.font = UIFont.systemFont(ofSize: 18.0)
        self.label?.textAlignment = .center
        self.label?.textColor = .white
        self.label?.numberOfLines = 0
        self.label?.layer.cornerRadius = 10
        self.label?.layer.masksToBounds = true
        self.label?.backgroundColor = UIColor.init(red: 0.0 / 255.0, green: 191.0 / 255.0, blue: 255.0 / 255.0, alpha: 1)
        self.contentView.addSubview(self.label!)
    }
    
    
    
    
    
    
    
    
    
}
