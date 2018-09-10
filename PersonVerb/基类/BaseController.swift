//
//  BaseController.swift
//  PersonVerb
//
//  Created by GongHua Guo on 2018/1/15.
//  Copyright © 2018年 GongHua Guo. All rights reserved.
//

import UIKit

let SCREENW = UIScreen.main.bounds.size.width
let SCREENH = UIScreen.main.bounds.size.height
let navHieght : CGFloat = SCREENH == 812 ? 88 : 64

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
    
    
    /**
     通过字符串创建一个类
     */
    func creatViewControllerFromStr(classStr : String) -> (UIViewController){
        let namespace = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
        //注意工程中必须有相关的类，否则程序会crash
        let vcClass : AnyObject = NSClassFromString(namespace + "." + classStr)!
        // 告诉编译器它的真实类型
        let viewControllerClass = vcClass as! UIViewController.Type
        return viewControllerClass.init()
    }
   
}


