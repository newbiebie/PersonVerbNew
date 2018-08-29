//
//  MasoryViewController.swift
//  PersonVerb
//
//  Created by GongHua Guo on 2018/3/19.
//  Copyright © 2018年 GongHua Guo. All rights reserved.
//

import UIKit

class MasoryViewController: BaseCanbackViewController {

    
    var labelOne : UILabel?
    
    var labelSecond : UILabel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelOne = UILabel.init()
        
        //使用Masonry布局需要先添加父视图， 否则报错
        self.view.addSubview(self.labelOne!)
        self.labelOne?.text = "1、第一个模块"
        self.labelOne?.font = UIFont.boldSystemFont(ofSize: 25.0)
        self.labelOne?.textColor = .orange
        self.labelOne!.mas_makeConstraints { (maker) in
            maker?.top.equalTo()(self.view)?.setOffset(CGFloat(navHieght) + 20)
            maker?.left.equalTo()(self.view)?.setOffset(20)
        }
        
        
        //第一个模块的详细布局
        self.creatFirstVerb()
        
        
        //第二个模块创建
        labelSecond = UILabel()
        self.view.addSubview(labelSecond!)
        labelSecond?.text = "2、第二个模块， 居中显示"
        labelSecond?.textColor = .lightGray
        labelSecond?.font = UIFont.boldSystemFont(ofSize: 25.0)
        labelSecond!.mas_makeConstraints { (maker) in
            maker?.center.equalTo()(self.view)
        }
        
        
        //第二个模块详情
        self.creatSecondVerb()
        
    }
    
    /**第一个模块创建*/
    func creatFirstVerb(){
        /**居中按钮*/
        let button = UIButton.init()
        self.view.addSubview(button)
        button.setTitle("中间", for: .normal)
        button.layer.cornerRadius = 5
        button.backgroundColor = .orange
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.red, for: .highlighted)
        button.mas_makeConstraints { (maker) in
            maker?.centerX.equalTo()(self.view)
            maker?.size.setSizeOffset(CGSize.init(width: 100, height: 30))
            maker?.top.equalTo()(self.labelOne!.mas_bottom)?.setOffset(15)
        }
        
        /**两个等宽的控件*/
        let buttonArray = NSMutableArray.init(capacity: 2)
        
        for index in stride(from: 0, to: 2, by: 1){
            let btn = UIButton.init()
            self.view.addSubview(btn)
            btn.setTitle(index == 0 ? "左边" : "右边", for: .normal)
            btn.setTitleColor(.white, for: .normal)
            btn.backgroundColor = .orange
            btn.setTitleColor(.green, for: .highlighted)
            btn.layer.cornerRadius = 8
            buttonArray.add(btn)
        }
        
        buttonArray.mas_distributeViews(along: .horizontal, withFixedSpacing: 20, leadSpacing: 20, tailSpacing: 20)
        buttonArray.mas_makeConstraints { (maker) in
            maker?.top.equalTo()(button.mas_bottom)?.setOffset(30)
        }
    }
    
    /**第二个模块布局详情*/
    func creatSecondVerb(){
        
        //右侧三个小控件
        let viewB = UIView()
//        viewB.backgroundColor = .lightGray
        self.view.addSubview(viewB)
        
        viewB.mas_makeConstraints { (maker) in
            maker?.right.equalTo()(self.view)?.setOffset(0)
            maker?.top.equalTo()(self.labelSecond!.mas_bottom)?.setOffset(20)
            maker?.size.setSizeOffset(CGSize.init(width: 120, height: 40))
        }
        
        
        let imgArray = NSMutableArray.init(capacity: 3)
        for _ in stride(from: 0, to: 3, by: 1){
            let image = UIImageView.init()
            image.backgroundColor = UIColor.purple
            viewB.addSubview(image)
            imgArray.add(image)
        }
        
        
        /**
         1、第一个参数：along  -->   布局方向
         2、第二个参数：FixedSpacing --> 控件之间的间隔
         3、第三个参数：leadSpacing --> 左边控件距父视图左边距离
         4、第四个参数：tailSpacing --> 右边控件距父视图右边界距离
         */
        
        imgArray.mas_distributeViews(along: .horizontal, withFixedSpacing: 5, leadSpacing: 5, tailSpacing: 10)
        
        imgArray.mas_makeConstraints { (maker) in
            maker?.centerY.equalTo()(viewB.mas_centerY)
            let imageV = imgArray[0] as! UIImageView
            maker?.height.equalTo()(imageV.mas_width)
        }
        
        //label
        let label = UILabel()
        self.view.addSubview(label)
        
        //没有什么错误可以让历史低头。一切过往，都是时间的玩偶。
        label.text = "没有什么美好可以定格。没有什么黑暗可以永远。"
        label.textColor = .gray
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 18.0)
        
        label.mas_makeConstraints { (maker) in
            maker?.top.equalTo()(labelSecond?.mas_bottom)?.setOffset(20)
            maker?.left.equalTo()(self.view)?.setOffset(20.0)
            maker?.right.equalTo()(viewB.mas_left)?.setOffset(0)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

    

}
