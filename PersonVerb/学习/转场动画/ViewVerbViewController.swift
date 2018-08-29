//
//  ViewVerbViewController.swift
//  PersonVerb
//
//  Created by GongHua Guo on 2018/3/20.
//  Copyright © 2018年 GongHua Guo. All rights reserved.
//

import UIKit

//系统动画
class ViewVerbViewController: BaseCanbackViewController {
    
    var printView : UIImageView?
    
    var behindView : UIImageView?
    
    let padding : CGFloat = 20
    let itemWidth = (SCREENW - 5 * 20) / 4
    
    var isShow : Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.printView = UIImageView.init(frame: CGRect.init(x: 0, y: CGFloat(navHieght), width: SCREENW, height: SCREENH - bottomHeight - navHieght))
        self.behindView = UIImageView.init(frame: CGRect.init(x: 0, y: CGFloat(navHieght), width: SCREENW, height: SCREENH - bottomHeight - navHieght))
        self.printView?.image = UIImage.init(named: "number03")
        self.behindView?.image = UIImage.init(named: "number06")
        
        self.view.insertSubview(self.printView!, at: 1)
        self.view.insertSubview(self.behindView!, at: 0)
        
        self.printView?.backgroundColor = .red
        self.behindView?.backgroundColor = .gray
        self.animationCAT()
        
    }
    
    //动画选择界面创建
    func animationCAT(){
        let titleArray : Array<String> = ["渐变", "覆盖", "推出", "揭开", "立体旋转", "吮吸", "翻转", "水纹", "页面收起", "页面放下", "镜头打开", "镜头关闭"]
        
        let viewB = UIView()
        viewB.backgroundColor = UIColor.clear
       
        
        self.view.addSubview(viewB)
        
        viewB.mas_makeConstraints { (maker) in
            maker?.size.setSizeOffset(CGSize.init(width: SCREENW, height: SCREENW))
            maker?.centerX.equalTo()(self.view)
            maker?.bottom.equalTo()(self.view)?.setOffset(-40)
        }
        
        for index in stride(from: 0, to: 12, by: 1){
            let button = UIButton()
            viewB.addSubview(button)
            button.setTitle(titleArray[index], for: .normal)
            button.layer.cornerRadius = 5.0
            button.backgroundColor = UIColor.lightGray
            button.setTitleColor(.white, for: .normal)
            button.setTitleColor(.red, for: .highlighted)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 15.0)
            button.tag = index + 100
            button.addTarget(self, action: #selector(self.buttonClicked(button:)), for: .touchUpInside)
            button.frame = CGRect.init(x:  CGFloat(index).truncatingRemainder(dividingBy: 4) * (itemWidth + padding) + padding, y: CGFloat(index / 4) * (itemWidth + padding) + padding, width: itemWidth, height: itemWidth)
        }
        
    }
    
    //按钮点击事件
    @objc func buttonClicked(button : UIButton) {
        let animation = CATransition.init()
        animation.duration = 0.5
        let animationArray = [kCATransitionFade, kCATransitionMoveIn, kCATransitionPush, kCATransitionReveal, "cube", "suckEffect", "oglFlip", "rippleEffect", "pageCurl", "pageUnCurl", "cemeraIrisHollowOpen", "cameraIrisHollowClose"]
        
        animation.type = animationArray[button.tag - 100]
        
        
        self.view.layer .add(animation, forKey: nil)
        self.view.exchangeSubview(at: 0, withSubviewAt: 1)
    }
    
    @objc func rightAction() {
        self.isShow = !self.isShow
        
        UIView.transition(from: self.isShow ? self.printView! : self.behindView!, to: self.isShow ? self.behindView! : self.printView!, duration: 0.5, options: .transitionFlipFromRight) { (true) in
            
        }
        
    }
    
    //创建label
    func creatLabel(title :String, parentV : UIView) {
        let label = UILabel()
        label.textColor = .white
        label.text = title
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        label.sizeToFit()
        parentV.addSubview(label)
        label.center = parentV.center
    }
    
    func beginCustomAnimation(){
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

}
