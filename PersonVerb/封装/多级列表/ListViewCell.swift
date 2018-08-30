//
//  ListViewCell.swift
//  PersonVerb
//
//  Created by GongHua Guo on 2018/8/30.
//  Copyright © 2018年 GongHua Guo. All rights reserved.
//

import UIKit

class ListViewCell: UITableViewCell {
    
    let margin : CGFloat = 20
    let labelMargin : CGFloat = 8
    
    var imageV : UIImageView?
    var titleLabel : UILabel?
    var lastLabel : UILabel?
    
    private var simpleModel : ListModel?
    var model : ListModel {
        set {
            //赋值
            simpleModel = newValue
            self.titleLabel?.text = simpleModel?.title
            //打开状态
            if simpleModel!.isRoot && simpleModel!.isOpen {
                self.imageV?.image = UIImage.init(named: "减号")
            }
                
            //非打开状态
            else if simpleModel!.isRoot && (simpleModel!.isOpen == false){
                self.imageV?.image = UIImage.init(named: "加号")
            }
            
            var lastStr = ""
            if simpleModel!.isRoot == false{
                lastStr = " <最底级>"
            }
            else if simpleModel!.modelList.count > 0 {
                lastStr = " <可展开> "
            }
            else {
                lastStr = " <无数据> "
            }
            
            self.lastLabel?.text = lastStr
            let width : CGFloat = 20
            self.imageV!.mas_remakeConstraints({ (maker) in
                maker?.left.equalTo()(self.contentView)?.offset()((width + labelMargin) * simpleModel!.rowNumber + margin)
                maker?.centerY.equalTo()(self.contentView)
                maker?.size.sizeOffset()(CGSize.init(width: width, height: width))
            })
            self.imageV?.isHidden = !(simpleModel!.isRoot);
        }
        get{
            return self.simpleModel!
        }
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: UI设置
    /**
     界面UI设计
     */
    func setUI(){
        
        //UIimageView
        self.imageV = UIImageView.init()
        self.contentView.addSubview(self.imageV!)
        
        self.imageV?.image = UIImage.init(named: "加号")
        self.imageV!.mas_makeConstraints({ (maker) in
            maker?.left.equalTo()(self.contentView)?.offset()(margin)
            maker?.centerY.equalTo()(self.contentView)
            maker?.size.sizeOffset()(CGSize.init(width: 20, height: 20))
        })
        
        //label
        self.titleLabel = UILabel.init()
        self.contentView.addSubview(self.titleLabel!)
        
        self.titleLabel?.textColor = .orange
        self.titleLabel?.font = UIFont.systemFont(ofSize: 17.0)
        self.titleLabel!.mas_makeConstraints { (maker) in
            maker?.left.equalTo()(self.imageV?.mas_right)?.offset()(labelMargin)
            maker?.centerY.equalTo()(self.imageV?.mas_centerY)
        }
        
        //提示label
        self.lastLabel = UILabel.init()
        self.contentView.addSubview(self.lastLabel!)
        
        self.lastLabel?.textColor = UIColor.red
        self.lastLabel?.font = UIFont.systemFont(ofSize: 16.0)
        self.lastLabel!.mas_makeConstraints { (maker) in
            maker?.centerY.equalTo()(self.imageV!.mas_centerY)
            maker?.left.equalTo()(self.titleLabel!.mas_right)?.offset()(labelMargin)
            maker?.right.equalTo()(self.contentView)?.offset()(-labelMargin)
        }
    }

}
