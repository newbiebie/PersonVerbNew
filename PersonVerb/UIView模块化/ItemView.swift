//
//  ItemView.swift
//  PersonVerb
//
//  Created by GongHua Guo on 2018/2/5.
//  Copyright © 2018年 GongHua Guo. All rights reserved.
//

import UIKit

/**
 对应的模块
 */

class ItemView: UIView {

    var title : UILabel?
    var descriptionLabel : UILabel?
    
    
    //数据填充
    var model : ItemModel? {
        willSet{
            
        } didSet {
            self.title?.text = model?.title
            self.descriptionLabel?.text = model?.descriptionStr
            self.layoutIfNeeded()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI() {
        
        //内容前面的数据
        self.title = UILabel.init()
        self.addSubview(self.title!)
        self.title?.font = UIFont.systemFont(ofSize: 13.0)
        self.title?.textColor = .red
        self.title?.textAlignment = .center
        self.title?.layer.cornerRadius = 5
        self.title?.layer.masksToBounds = true
        self.title?.layer.borderWidth = 0.8
        self.title?.layer.borderColor = UIColor.red.cgColor
        
//        self.title?.backgroundColor = UIColor.orange
        
        
        
        //内容
        self.descriptionLabel = UILabel.init()
        self.addSubview(self.descriptionLabel!)
        self.descriptionLabel?.font = UIFont.systemFont(ofSize: 17.0)
        self.descriptionLabel?.textColor = .orange
        self.descriptionLabel?.numberOfLines = 0
        
    }
    
    
    //重新布局
    override func layoutSubviews() {
        super.layoutSubviews()
        self.title?.sizeToFit()
        self.title?.frame = CGRect.init(x: 0, y: 0, width: (self.title?.frame.size.width)! + 6, height: (self.title?.frame.size.height)! + 5)
        
        
        //富文本设置文本样式  首行缩进  行间距
        let style : NSMutableParagraphStyle = NSMutableParagraphStyle.init()
        
        //缩进距离
        style.firstLineHeadIndent = self.title!.frame.size.width + 6
        style.lineSpacing = 5
        let attributes = [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 17.0),
                          NSAttributedStringKey.paragraphStyle : style]
        self.descriptionLabel?.attributedText = NSAttributedString.init(string: (self.descriptionLabel?.text)!, attributes: attributes)
        
        self.descriptionLabel?.frame = CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: 30)
        self.descriptionLabel?.sizeToFit()
        
        self.frame.size = CGSize.init(width: self.frame.size.width, height: (self.descriptionLabel?.frame.size.height)!)
    }
    
}
