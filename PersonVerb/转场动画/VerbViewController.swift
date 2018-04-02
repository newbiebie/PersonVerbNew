//
//  VerbViewController.swift
//  PersonVerb
//
//  Created by GongHua Guo on 2018/3/20.
//  Copyright © 2018年 GongHua Guo. All rights reserved.
//

import UIKit

class VerbViewController: BaseController {
    
    var rightButton : UIButton?
    
    var leftButton : UIButton?
    
    lazy var label : UILabel = {
        
        let label = UILabel()
        label.center = self.view.center
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 25.0)
        label.textColor = .orange
        return label
    }()
    
    
    
    //Button初始化
    func creatButton(title : String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18.0)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .orange
        button.layer.cornerRadius = 10.0
        button.addTarget(self, action: #selector(self.buttonClicked(button:)), for: .touchUpInside)
        return button
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.label)
        self.label.text = "这个是扫描界面。"
        self.buttonLayout()
        
        self.leftButton?.isEnabled = false
        self.rightButton?.isEnabled = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("收到内存警告！！")
    }
    
    @objc func buttonClicked(button : UIButton) {
        
        /**
         UIViewAnimationTransitionNone, 不使用动画
         UIViewAnimationTransitionFlipFromLeft, 从左向右翻转
         UIViewAnimationTransitionFlipFromRight, 从右向左翻转
         UIViewAnimationTransitionCurlUp,卷曲翻页， 从下往上
         UIViewAnimationTransitionCurlDown, 卷曲翻页， 从上往下
         */
        
        if button.titleLabel?.text == "扫描" {
            UIView.beginAnimations(nil, context: nil)
            UIView.setAnimationCurve(.easeInOut)
            UIView.setAnimationDuration(0.5)
            
            UIView.setAnimationTransition(.flipFromLeft, for: (self.navigationController?.view)!, cache: false)
            self.navigationController?.popViewController(animated: true)
            
            UIView.commitAnimations()
        }
        else if button.titleLabel?.text == "二维码" {
            
            let vc = VerbTwoViewController()
            
            UIView.beginAnimations(nil, context: nil)
            UIView.setAnimationCurve(.easeInOut)
            UIView.setAnimationDuration(0.5)
            
            UIView.setAnimationTransition(.flipFromRight, for: (self.navigationController?.view)!, cache: false)
            self.navigationController?.pushViewController(vc, animated: true)
            UIView.commitAnimations()
        }
    }
    
    func buttonLayout(){
        self.leftButton = self.creatButton(title: "扫描")
        self.rightButton = self.creatButton(title: "二维码")
        self.view.addSubview(self.rightButton!)
        self.rightButton!.mas_makeConstraints({ (maker) in
            maker?.bottom.equalTo()(self.view)?.setOffset(-100)
            maker?.left.equalTo()(self.view.mas_centerX)?.setOffset(20)
            maker?.size.setSizeOffset(CGSize.init(width: 120, height: 40))
        })
        
        self.view.addSubview(self.leftButton!)
        self.leftButton!.mas_makeConstraints { (maker) in
            maker?.bottom.equalTo()(self.view)?.setOffset(-100)
            maker?.right.equalTo()(self.view.mas_centerX)?.setOffset(-20)
            maker?.size.setSizeOffset(CGSize.init(width: 120, height: 40))
        }
    }
    
    
    
}
