//
//  BaseController.swift
//  PersonVerb
//
//  Created by GongHua Guo on 2018/1/15.
//  Copyright © 2018年 GongHua Guo. All rights reserved.
//

import UIKit

class BaseController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**
     根据屏幕宽度获取对应比例
     */
    func scaleFromWidth(value : CGFloat) -> CGFloat{
        return value * SCREENW / 375;
    }
    
   
}


