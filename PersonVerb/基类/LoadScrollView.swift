//
//  LoadScrollView.swift
//  PersonVerb
//
//  Created by GongHua Guo on 2018/1/15.
//  Copyright © 2018年 GongHua Guo. All rights reserved.
//

import UIKit
let SCREENW = UIScreen.main.bounds.size.width
let SCREENH = UIScreen.main.bounds.size.height
let navHieght = SCREENH == 812 ? 88 : 64

protocol LoadScrollViewDelegate {
    
    //button点击事件
    func buttonSelected()
    
    //图片点击事件
    func imageSelected(item : NSInteger)
}

class LoadScrollView: UIView , UIScrollViewDelegate {
    
    //右上侧的跳过按钮
    var scrollView : UIScrollView?
    
    //计时器
    var timer : Timer?
    
    //时间
    var timeNum : NSInteger = 5
    
    //图片数据源
    var imageArray : Array<NSString>?
    
    //pageControl
    var pageControl : UIPageControl?
    
    var ItemDelegate : LoadScrollViewDelegate?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.scrollView = UIScrollView.init(frame: self.bounds)
        self.addSubview(self.scrollView!)
        self.scrollView?.delegate = self
        self.scrollView?.bounces = false
        self.scrollView?.showsVerticalScrollIndicator = false
        self.scrollView?.showsHorizontalScrollIndicator = false
        self.scrollView?.isPagingEnabled = true
        
    }
    
    //自动出现
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func creatU(){
        
        
        if self.imageArray == nil {
            return;
        }
        
        //循环创建图片
        for NSStringItem in self.imageArray! {
            
            let index : CGFloat = CGFloat(imageArray!.index(of: NSStringItem)!)
            
            let imaageView : UIImageView = UIImageView.init(frame: CGRect.init(x: index * SCREENW, y: 0, width: SCREENW, height: SCREENH))
            imaageView.isUserInteractionEnabled = true
            
            imaageView.image = UIImage.init(named: NSStringItem as String)
            
            imaageView.tag = Int(index)
            imaageView.backgroundColor = .red
            self.scrollView?.addSubview(imaageView)
            
            //添加点击事件
            let tap = UITapGestureRecognizer.init(target: self, action: #selector(self.actionNow(gesture:)))
            imaageView.addGestureRecognizer(tap)
        }
        
        //添加button
        
        let button : UIButton = UIButton.init(frame: CGRect.init(x: SCREENW - 100, y: 40, width: 80, height: 28))
        button.setTitle(NSString.init(format: "跳过 %dS", self.timeNum) as String, for: .normal)
        button.layer.cornerRadius = 14
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17.0)
        button.layer.masksToBounds = true
        button.backgroundColor = UIColor.init(white: 0.3, alpha: 0.5)
        self.addSubview(button)
        
        //button的事件响应
        button.addTarget(self, action: #selector(self.buttonAction), for: .touchUpInside)
        
        
        //添加pageControl
        if self.imageArray!.count > 1 {
            
            self.pageControl = UIPageControl.init(frame: CGRect.init(x: SCREENW / 2 - 50, y: SCREENH - 60, width: 100, height: 30))
            self.pageControl?.numberOfPages = (self.imageArray?.count)!
            self.addSubview(self.pageControl!)
            self.pageControl?.pageIndicatorTintColor = .gray
            self.pageControl?.currentPageIndicatorTintColor = .white
        }
        
        self.scrollView?.contentSize = CGSize.init(width: CGFloat(self.imageArray!.count) * SCREENW, height: 0)
        
        
        //添加计时器, 固定时间后去掉当前显示的页面
        if #available(iOS 10.0, *) {
            self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { (timer) in
                self.timeNum = self.timeNum - 1
                button.setTitle(NSString.init(format: "跳过 %dS", self.timeNum) as String, for: .normal)
                
                if self.timeNum <= 0 {
                    self.timerClick()
                }
            })
        } else {
            print("系统版本比较低!!")
        }
    }
    
    func timerClick() {
        if (self.timer != nil) {
            self.timer?.invalidate()
            self.timer = nil
        }
        
        //调用buttonClick即可
        self.buttonAction()
    }
    
    //图片点击事件
    @objc func actionNow(gesture : UITapGestureRecognizer){
        
        if (self.ItemDelegate != nil && ((gesture.view?.tag) != nil)) {
            self.ItemDelegate?.imageSelected(item: (gesture.view?.tag)!)
        }
    }
    
    @objc func buttonAction(){
        
        if self.ItemDelegate != nil {
            self.ItemDelegate?.buttonSelected()
        }
    }
    
    
    //scrollView的代理回调方法
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.pageControl?.currentPage = Int(scrollView.contentOffset.x / SCREENW)
    }
}
