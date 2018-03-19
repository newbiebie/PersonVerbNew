//
//  MasonryCell.swift
//  PersonVerb
//
//  Created by GongHua Guo on 2018/3/19.
//  Copyright © 2018年 GongHua Guo. All rights reserved.
//

import UIKit

class MasonryCell: UITableViewCell {
    
    
    var contentLabel : UILabel?
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        
        self.setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    func setUI() {
        let viewB = UIView()
        self.addSubview(viewB)

        viewB.mas_makeConstraints { (maker) in
            maker?.size.setSizeOffset(CGSize.init(width: SCREENW - 20, height: 35))
            maker?.centerX.equalTo()(self)
            maker?.bottom.equalTo()(self)?.setOffset(-15)
        }
        viewB.layer.borderWidth = 0.8
        viewB.layer.borderColor = UIColor.lightGray.cgColor
        viewB.layer.cornerRadius = 5
        
        let labelArray = NSMutableArray.init(capacity: 2)
        let buttonArray = NSMutableArray.init(capacity: 3)
        
        let titleArray : Array<String> = ["点赞", "喜欢", "收藏"]
        
        for index in stride(from: 0, to: 3, by: 1){
            let button = UIButton.init()
            button.setTitle(titleArray[index], for: .normal)
            button.setTitleColor(.gray, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 16.0)
            button.setImage(UIImage.init(named: titleArray[index]), for: .normal)
            button.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 5.0)
            button.setTitleColor(.red, for: .highlighted)
            viewB.addSubview(button)
            button.mas_makeConstraints({ (maker) in
                maker?.centerY.equalTo()(viewB)
                maker?.height.setOffset(30)
            })
            buttonArray.add(button)
        }
        
        buttonArray.mas_distributeViews(along: .horizontal, withFixedSpacing: 20, leadSpacing: 20, tailSpacing: 20)
        
        for _ in stride(from: 0, to: 2, by: 1){
            let label = UILabel()
            label.backgroundColor = .gray
            viewB.addSubview(label)
            label.mas_makeConstraints({ (maker) in
                maker?.size.setSizeOffset(CGSize.init(width: 1, height: 20))
                maker?.centerY.equalTo()(viewB)
            })
            labelArray.add(label)
        }
        let itemPad = (SCREENW - 22) / 3
        labelArray.mas_distributeViews(along: .horizontal, withFixedSpacing: itemPad, leadSpacing: itemPad, tailSpacing: itemPad)
        
        //右侧图片
        let image = UIImageView.init()
        self.addSubview(image)
        image.backgroundColor = .orange
        
        image.mas_makeConstraints { (maker) in
            maker?.top.equalTo()(self)?.setOffset(10.0)
            maker?.right.equalTo()(self)?.setOffset(-10.0)
            maker?.bottom.equalTo()(viewB.mas_top)?.setOffset(-10.0)
            maker?.width.setOffset(50)
        }
        
        
        //内容label
        self.contentLabel = UILabel()
        self.addSubview(self.contentLabel!)
        self.contentLabel?.numberOfLines = 0
        self.contentLabel?.textColor = .red
        self.contentLabel?.font = UIFont.systemFont(ofSize: 18.0)
        
        self.contentLabel!.mas_makeConstraints({ (maker) in
            maker?.top.equalTo()(image)
            maker?.left.equalTo()(self)?.setOffset(10)
            maker?.right.equalTo()(image.mas_left)?.setOffset(-10.0)
            maker?.bottom.equalTo()(viewB.mas_top)?.setOffset(-10.0)
        })
        
    }
}
