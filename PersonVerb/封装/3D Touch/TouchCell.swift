//
//  TouchCell.swift
//  PersonVerb
//
//  Created by GongHua Guo on 2018/10/17.
//  Copyright © 2018年 GongHua Guo. All rights reserved.
//

import UIKit

class TouchCell: UITableViewCell {

    var imageVC : UIImageView?
    var contentLabel : UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI() {
        
        self.imageVC = UIImageView.init()
        self.contentView.addSubview(imageVC!)
        
        self.imageVC!.mas_makeConstraints { (maker) in
            maker?.top.equalTo()(self.contentView)?.offset()(20)
            maker?.left.equalTo()(self.contentView)?.offset()(18)
            maker?.size.sizeOffset()(CGSize.init(width: 40, height: 40))
            maker?.bottom.equalTo()(self.contentView)?.offset()(-20)
        }
        
        self.imageVC?.layer.masksToBounds = true
        self.imageVC?.layer.cornerRadius = 8
        
        self.contentLabel = UILabel.init()
        self.contentView.addSubview(self.contentLabel!)
        
        self.contentLabel!.mas_makeConstraints { (maker) in
            maker?.top.equalTo()(self.imageVC)
            maker?.left.equalTo()(self.imageVC?.mas_right)?.offset()(8)
            maker?.right.equalTo()(self.contentView)?.offset()(-18)
            maker?.bottom.equalTo()(self.imageVC)
        }
        
        self.contentLabel?.textColor = UIColor.orange
        self.contentLabel?.font = UIFont.systemFont(ofSize: 16.0 * SCREENW / 375)
        self.contentLabel?.numberOfLines = 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
