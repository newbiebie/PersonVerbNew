//
//  TitleImage.swift
//  SwiftExercise
//
//  Created by xunji on 2018/5/24.
//  Copyright © 2018年 xunji. All rights reserved.
//

import UIKit

let imageSpace : CGFloat = 10
//扩展UIimageView  效果
class TitleImage: UIView {
    
    
    
    //底部点击按钮
    var button : UIButton?
    
    var imageView : UIImageView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.customPathAnimation()
        
        //调用布局方法
        self.setUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    /**设置UI界面布局*/
    func setUI() {
        self.backgroundColor = .gray
        
        self.imageView = UIImageView.init()
        self.addSubview(self.imageView!)
        self.imageView?.layer.cornerRadius = 8
        self.imageView?.layer.masksToBounds = true
        
        self.imageView!.mas_makeConstraints({ (maker) in
            maker?.edges.setInsets(UIEdgeInsetsMake(imageSpace, imageSpace, imageSpace, imageSpace))
        })
        
        self.button = UIButton.init()
        self.addSubview(self.button!)
        
        self.button?.setTitle("获取", for: .normal)
        self.button?.setTitleColor(.white, for: .normal)
        self.button?.titleLabel?.font = UIFont.systemFont(ofSize: 13.0)
        
        self.button?.layer.borderColor = UIColor.gray.cgColor
        self.button?.layer.borderWidth = 2.0
        self.button?.layer.cornerRadius = 25 * SCREENW / 375 / 2
        
        self.button?.backgroundColor = .orange
        self.button!.mas_makeConstraints({ (maker) in
            maker?.centerX.equalTo()(self)
            maker?.size.setSizeOffset(CGSize.init(width: self.frame.size.width * 0.7, height: 25 * SCREENW / 375))
            maker?.bottom.equalTo()(self.mas_bottom)?.offset()(-8 * SCREENW / 375 - imageSpace)
        })
    }
    
    
    /**
     自定义路径动画
     */
    func customPathAnimation(){
        
        let animationTime = 5
        let angleNumber = 120
        
        let copyLayer = CAReplicatorLayer.init()
        copyLayer.frame = CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        self.layer.addSublayer(copyLayer)
        
        copyLayer.instanceDelay = Double(animationTime) / Double(angleNumber)
        copyLayer.instanceCount = angleNumber
        copyLayer.instanceGreenOffset = -0.03
        copyLayer.instanceRedOffset = -0.02
        copyLayer.instanceBlueOffset = -0.01
        
        let baseLayer = CAShapeLayer.init()
        baseLayer.frame = CGRect.init(x: 2, y: 2, width: 6, height: 6)
        baseLayer.fillColor = UIColor.orange.cgColor
//        baseLayer.path = UIBezierPath.init(ovalIn: CGRect.init(x: 0, y: 0, width: 6, height: 6)).cgPath
        baseLayer.path = UIBezierPath.init(rect: CGRect.init(x: 0, y: 0, width: 6, height: 6)).cgPath
        copyLayer.addSublayer(baseLayer)
        
        let indexNum : CGFloat = 5
        let path = UIBezierPath.init()
        path.move(to: CGPoint.init(x: indexNum, y: indexNum))
        path.addLine(to: CGPoint.init(x: self.frame.size.width - indexNum, y: indexNum))
        path.addLine(to: CGPoint.init(x: self.frame.size.width - indexNum, y: self.frame.size.height - indexNum))
        path.addLine(to: CGPoint.init(x: indexNum, y: self.frame.size.height - indexNum))
        path.close()
        
        let animation2 = CAKeyframeAnimation.init(keyPath: "position")
        animation2.path = path.cgPath
        animation2.repeatCount = MAXFLOAT
        animation2.duration = CFTimeInterval(animationTime)
        animation2.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionLinear)
        
        baseLayer.add(animation2, forKey: "group")
    }
    
}
