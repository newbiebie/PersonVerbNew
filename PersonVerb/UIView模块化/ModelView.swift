//
//  ModelView.swift
//  PersonVerb
//
//  Created by GongHua Guo on 2018/2/5.
//  Copyright © 2018年 GongHua Guo. All rights reserved.
//

import UIKit


/**
 多模块组合视图
 */

class ModelView: UIView {
    
    let betweenSpace : CGFloat = 5
    let leftSpace : CGFloat = 10
    
    var itemArray : Array<ItemModel>? {
        
        willSet {
            
        }
        didSet{
            
            //可以进行一些UI界面的处理
            var lastView  = UIView.init()
            for i in 0..<itemArray!.count{
                let itemView : ItemView = ItemView.init(frame: CGRect.init())
                self.addSubview(itemView)
                
                if (lastView.isKind(of: ItemView.self)){
                    itemView.frame = CGRect.init(x: self.leftSpace, y: lastView.frame.maxY + betweenSpace, width: self.frame.size.width - self.leftSpace * 2, height: 0)
                }
                else {
                    itemView.frame = CGRect.init(x: self.leftSpace, y: 40 + betweenSpace * 2, width: self.frame.size.width - leftSpace * 2, height: 0)
                }
                itemView.model = self.itemArray?[i]
                lastView = itemView
            }
            
            //调整自身的尺寸
            self.frame.size = CGSize.init(width: self.frame.size.width, height: lastView.frame.origin.y + betweenSpace * 2)
            self.frame = CGRect.init(x: self.frame.origin.x, y: self.frame.origin.y, width: self.frame.size.width, height: lastView.frame.maxY + betweenSpace * 2)
            
            //添加虚框
            let imgLine = CAShapeLayer.init()
            imgLine.frame = CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
            imgLine.path = UIBezierPath.init(roundedRect: self.bounds, cornerRadius: 10.0).cgPath
            imgLine.lineWidth = 2
            imgLine.lineDashPattern = [15, 5]
            imgLine.fillColor = UIColor.clear.cgColor
            imgLine.strokeColor = UIColor.orange.cgColor
            self.layer .addSublayer(imgLine)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**UI布局*/
    func setUI() {
        
        //添加提醒label
        let titleLabel = UILabel.init(frame: CGRect.init(x: leftSpace, y: betweenSpace, width: self.frame.size.width - leftSpace * 2, height: 40))
        titleLabel.text = "组件模块化尝试"
        titleLabel.textColor = UIColor.orange
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        self.addSubview(titleLabel)
    }
    
    
}
