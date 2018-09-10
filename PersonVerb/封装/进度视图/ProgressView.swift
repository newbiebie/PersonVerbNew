//
//  ProgressView.swift
//  PersonVerb
//
//  Created by GongHua Guo on 2018/8/31.
//  Copyright © 2018年 GongHua Guo. All rights reserved.
//


import UIKit

class ProgressView: UIView {

    var imageView : UIImageView?
    var content : UILabel?
    
    private var progress : CGFloat = 0.0
    
    init(frame: CGRect, progress : CGFloat) {
        super.init(frame: frame)
        self.progress = progress;
        self.layoutIfNeeded()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutIfNeeded() {
        self.setUI()
    }

    //MARK:界面UI
    func setUI(){
        self.imageView = UIImageView.init(frame: self.bounds)
        self.addSubview(self.imageView!)
        
        self.imageView?.layer.masksToBounds = true
        self.imageView?.layer.cornerRadius = self.bounds.size.width / 2
        self.imageView?.image = UIImage.init(named: "iconImage")
        
        self.content = UILabel.init(frame: self.bounds)
        self.addSubview(self.content!)
        
        self.content?.textAlignment = .center
        self.content?.textColor = UIColor.red
        self.content?.font = UIFont.boldSystemFont(ofSize: 20.0)
        self.content?.text = NSString.init(format: "%.0f", self.progress).appending("%")
        
        //添加显示层layer
        let layer = CAShapeLayer.init()
        layer.frame = self.bounds
        
        layer.strokeColor = UIColor.white.cgColor
        layer.fillColor = UIColor.clear.cgColor
        layer.lineCap = kCALineJoinRound
        layer.lineWidth = 5
        let path = UIBezierPath.init(arcCenter: CGPoint.init(x: self.bounds.size.width / 2, y: self.bounds.size.height / 2), radius: self.bounds.size.width / 2 - 8, startAngle: CGFloat(Double.pi * 3 / 2), endAngle: CGFloat(Double.pi * Double(1.5 + self.progress / 100 * 2)), clockwise: true)
        layer.path = path.cgPath
        self.layer.addSublayer(layer)
        layer.add(self.animationForLayer(), forKey: "strokeEnd")
    }
    
    /**添加一个从零到一的动画效果*/
    func animationForLayer() -> CABasicAnimation {
        let animation = CABasicAnimation.init(keyPath: "strokeEnd")
        animation.duration = 1.5
        animation.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionLinear)
        animation.fromValue = 0
        animation.toValue = 1
        animation.isRemovedOnCompletion = false
        return animation
    }
}
