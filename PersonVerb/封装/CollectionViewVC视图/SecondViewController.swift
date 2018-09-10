//
//  SecondViewController.swift
//  PersonVerb
//
//  Created by GongHua Guo on 2018/9/10.
//  Copyright © 2018年 GongHua Guo. All rights reserved.
//

import UIKit

class SecondViewController: BaseCanbackViewController, UINavigationControllerDelegate {

    var titleStr = ""
    var imageStr : String?
    var imageView : UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = self.titleStr
        
        self.setUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.delegate = self
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: UI界面设置
    func setUI(){
        
        self.imageView = UIImageView.init()
        self.view.addSubview(imageView!)
        
        imageView?.backgroundColor = .white
        if self.imageStr != nil {
            imageView?.image = UIImage.init(named: self.imageStr!)
        }
        imageView?.layer.cornerRadius = 8
        imageView?.layer.masksToBounds = true
        
        imageView!.mas_makeConstraints { (maker) in
            maker?.top.equalTo()(self.view)?.offset()(navHieght + 20)
            maker?.left.equalTo()(self.view)?.offset()(20)
            maker?.right.equalTo()(self.view)?.offset()(-20)
            maker?.height.offset()(SCREENH * 0.4)
        }
        
        let label = UILabel.init()
        self.view.addSubview(label)
        
        label.text = "人生的道路十分漫长，前进中布满了荆棘。我们总是面临着一次又一次的转折。如何迈进每一步都要我们自己做出抉择。"
        label.textColor = .orange
        label.font = UIFont.systemFont(ofSize: 17.0)
        label.numberOfLines = 0
        
        label.mas_makeConstraints { (maker) in
            maker?.top.equalTo()(imageView!.mas_bottom)?.offset()(50)
            maker?.left.equalTo()(self.view)?.offset()(20)
            maker?.right.equalTo()(self.view)?.offset()(-20)
        }
        self.view.layoutIfNeeded()
    }
    
    //MARK: UINavgationControllerDelegate协议实现  push的时候效果
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        if (toVC.isKind(of:CollectionViewVCViewController.self) && operation == UINavigationControllerOperation.pop) {
            return NavgationAnimation.init(type: .pop)
        }
        else {
            return nil
        }
    }
    
}
