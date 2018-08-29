//
//  RandomViewController.swift
//  SwiftExercise
//
//  Created by xunji on 2018/8/10.
//  Copyright © 2018年 xunji. All rights reserved.
//

import UIKit

class RandomViewController: BaseCanbackViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.title = "不规则图形"
        
        self.setUI()
        self.setUILabelNow()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /**
     页面初始布局
     */
    func setUI(){
        let button = UIButton.init()
        self.view.addSubview(button)
        
        button.setTitle("头像", for: .normal)
        button.setTitleColor(.orange, for: .normal)
        
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18.0)
        
        button.mas_makeConstraints { (maker) in
            maker?.top.equalTo()(self.view)?.offset()(navHieght + SCREENW * 0.3)
            maker?.left.equalTo()(self.view)?.offset()(SCREENW * 0.15)
        }
        
        //添加UIimageView
        let imageView = UIImageView.init()
        self.view.addSubview(imageView)
        
        imageView.image = UIImage.init(named: "iconImage")
        
        imageView.mas_makeConstraints { (maker) in
            maker?.centerY.equalTo()(button.mas_centerY)
            maker?.left.equalTo()(button.mas_right)?.offset()(15)
            maker?.size.sizeOffset()(CGSize.init(width: SCREENW * 0.4, height: SCREENW * 0.4))
        }
        
        let maskLayer = CAShapeLayer.init()
        maskLayer.fillColor = UIColor.black.cgColor
        maskLayer.strokeColor = UIColor.clear.cgColor
        
        
        let path = UIBezierPath.init()
        path.move(to: CGPoint.init(x: 10, y: 0))
        path.addLine(to: CGPoint.init(x: SCREENW * 0.3 - 15, y: 0))
//        path.addQuadCurve(to: CGPoint.init(x: SCREENWIDTH * 0.3, y: 15), controlPoint: CGPoint.init(x: SCREENWIDTH * 0.3 - 15, y: 0))
        
        path.addLine(to: CGPoint.init(x: SCREENW * 0.4, y: SCREENW * 0.2))
        path.addLine(to: CGPoint.init(x: SCREENW * 0.4, y: SCREENW))
        path.addLine(to: CGPoint.init(x: 10, y: SCREENW))
        
        path.addLine(to: CGPoint.init(x: 10, y: SCREENW * 0.2 + 5))
        path.addLine(to: CGPoint.init(x: 0, y: SCREENW * 0.2))
        path.addLine(to: CGPoint.init(x: 10, y: SCREENW * 0.2 - 5))
        path.close()
        maskLayer.path = path.cgPath
        imageView.layer.mask = maskLayer
        
    }
    
    
    //添加一个不规则的UILabel
    func setUILabelNow(){
        
        
        let titleLabel = UILabel.init()
        self.view.addSubview(titleLabel)
        
        let nowWidth = SCREENW * 0.8
        let nowHeoght : CGFloat = 50
        let spaceline : CGFloat = 12
        titleLabel.text = "这是一个不规则的UILabel"
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor.white
        titleLabel.backgroundColor = UIColor.orange
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18.0)
        
        titleLabel.mas_makeConstraints { (maker) in
            maker?.bottom.equalTo()(self.view.mas_bottom)?.offset()(-bottomHeight - 50)
            maker?.centerX.equalTo()(self.view)
            maker?.size.sizeOffset()(CGSize.init(width: nowWidth, height: nowHeoght))
        }
        
        let maskLayer = CAShapeLayer.init()
        maskLayer.strokeColor = UIColor.clear.cgColor
        
        //定义路径
        let path = UIBezierPath.init()
        //倒三角中心开始绘制
        path.move(to: CGPoint.init(x: nowWidth / 2, y: nowHeoght - spaceline))
        path.addLine(to: CGPoint.init(x: nowWidth / 2 - spaceline / 2, y: nowHeoght))
        path.addLine(to: CGPoint.init(x: spaceline, y: nowHeoght))
        
        /**
         center：圆心的坐标
         radius：半径
         startAngle：起始的弧度
         endAngle：圆弧结束的弧度
         clockwise：YES为顺时针，No为逆时针
            */
        
        //左下弧度
        path.addArc(withCenter: CGPoint.init(x: spaceline, y: nowHeoght - spaceline), radius: spaceline, startAngle: CGFloat(Double.pi / 2), endAngle: CGFloat(Double.pi), clockwise: false)
        path.addLine(to: CGPoint.init(x: 0, y: spaceline))
        
        //左上弧度
        path.addArc(withCenter: CGPoint.init(x: spaceline, y: spaceline), radius: spaceline, startAngle: CGFloat(Double.pi), endAngle: CGFloat(Double.pi * 1.5), clockwise: true)
        path.addLine(to: CGPoint.init(x: nowWidth - spaceline, y: 0))
        
        //右上弧度
        path.addArc(withCenter: CGPoint.init(x: nowWidth - spaceline, y: spaceline), radius: spaceline, startAngle: CGFloat(Double.pi * 1.5), endAngle: 0, clockwise: false)
        path.addLine(to: CGPoint.init(x: SCREENW, y: nowHeoght - spaceline))
        
        //右下弧度
        path.addArc(withCenter: CGPoint.init(x: nowWidth - spaceline, y: nowHeoght - spaceline), radius: spaceline, startAngle: 0, endAngle: CGFloat(Double.pi / 2), clockwise: true)
        path.addLine(to: CGPoint.init(x: nowWidth / 2 + spaceline / 2, y: nowHeoght))
        
        path.close()
        
        maskLayer.path = path.cgPath
        titleLabel.layer.mask = maskLayer
        
    }
 
}



