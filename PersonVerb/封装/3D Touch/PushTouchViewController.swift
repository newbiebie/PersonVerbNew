//
//  PushTouchViewController.swift
//  PersonVerb
//
//  Created by GongHua Guo on 2018/10/17.
//  Copyright © 2018年 GongHua Guo. All rights reserved.
//

import UIKit

class PushTouchViewController: BaseCanbackViewController {
    
    var imageView : UIImageView?
    var titleName : UILabel?
    
    var imageStr : String?
    var name : String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUI()
        self.title = "3D Touch 测试"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    //MARK 自定义方法使用
    func setUI() {
        self.imageView = UIImageView.init()
        self.view.addSubview(self.imageView!)
        
        self.imageView?.layer.masksToBounds = true
        self.imageView?.layer.cornerRadius = 15
        
        self.imageView?.mas_makeConstraints({ (maker) in
            maker?.top.equalTo()(self.view)?.offset()(navHieght + 20)
            maker?.centerX.equalTo()(self.view)
            maker?.size.sizeOffset()(CGSize.init(width: SCREENW * 0.9, height: SCREENW * 0.9))
        })
        
        self.imageView?.image = UIImage.init(named: self.imageStr!)
        
        self.titleName = UILabel.init()
        self.view.addSubview(self.titleName!)
        
        self.titleName?.textColor = .orange
        self.titleName?.font = UIFont.systemFont(ofSize: 17.0 * SCREENW / 375)
        self.titleName?.textAlignment = .center
        
        self.titleName?.mas_makeConstraints({ (maker) in
            maker?.top.equalTo()(self.imageView!.mas_bottom)?.offset()(20)
            maker?.left.equalTo()(self.imageView?.mas_left)
            maker?.right.equalTo()(self.imageView?.mas_right)
        })
        self.titleName?.text = self.name
       
    }
    
    override var previewActionItems: [UIPreviewActionItem] {
        let action1 = UIPreviewAction(title: "跳转", style: .default) { (action, previewViewController) in
            
        }
        let action3 = UIPreviewAction(title: "取消", style: .destructive) { (action, previewViewController) in
            print("我是取消按钮")
        }
        ////该按钮可以是一个组，点击该组时，跳到组里面的按钮。
        let subAction1 = UIPreviewAction(title: "测试1", style: .selected) { (action, previewViewController) in
            print("我是测试按钮1")
        }
        let subAction2 = UIPreviewAction(title: "测试2", style: .selected) { (action, previewViewController) in
            print("我是测试按钮2")
        }
        let subAction3 = UIPreviewAction(title: "测试3", style: .selected) { (action, previewViewController) in
            print("我是测试按钮3")
        }
        let groupAction = UIPreviewActionGroup(title: "更多", style: .default, actions: [subAction1, subAction2, subAction3])
        return [action1, action3, groupAction]
    }

}
