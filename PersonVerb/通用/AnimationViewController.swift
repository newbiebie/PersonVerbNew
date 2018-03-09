//
//  AnimationViewController.swift
//  PersonVerb
//
//  Created by GongHua Guo on 2018/3/8.
//  Copyright © 2018年 GongHua Guo. All rights reserved.
//

import UIKit
import CoreGraphics



class AnimationViewController: BaseController {
    
    let radius : Double = 180
    let circleTime = 2.0
    let circleNum = 3.0

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.lightGray
        
        let v = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 230, height: 230))
        v.center = self.view.center
        self.view.addSubview(v)
        
        
        let imageV = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: 200, height:200))
        imageV.layer.cornerRadius = 100
        imageV.layer.masksToBounds = true
        imageV.center = self.view.center
        imageV.image = UIImage.init(named: "number03")
        self.view.addSubview(imageV)
        
        v.startAnimation()
        
        
        
        
        
        //添加虚框线
//        let border = CAShapeLayer.init()
//        border.frame = imageV.bounds
//        border.lineWidth = 4
//        border.cornerRadius = 175
//        border.strokeColor = UIColor.darkGray.cgColor
//        border.fillColor = UIColor.clear.cgColor
//        border.lineDashPattern = [2, 5]
//
//        let path = UIBezierPath.init(roundedRect: border.frame, byRoundingCorners: [.topRight, .topLeft, .bottomRight, .bottomLeft], cornerRadii: CGSize.init(width: 175, height: 175))
//        border.path = path.cgPath
//        imageV.layer.addSublayer(border)
//
//        var isYes : Bool = true
//        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { (true) in
//            isYes = !isYes
//            border.lineDashPattern = [isYes ? 0 : 1, 5]
//        }
        
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
