//
//  ProgressViewController.swift
//  PersonVerb
//
//  Created by GongHua Guo on 2018/8/31.
//  Copyright © 2018年 GongHua Guo. All rights reserved.
//

import UIKit

class ProgressViewController: BaseCanbackViewController {

    //定义尺寸
    let space : CGFloat = 20
    let rowNumber : CGFloat = 3
    let progressArray : Array<CGFloat> = [50, 60, 20, 30, 100, 20, 80, 33, 5, 86, 29]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "进度视图设置"
        self.setUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

    //MARK: 界面设计
    func setUI(){
        
        let itemW : CGFloat = (SCREENW - (rowNumber + 1) * space) / rowNumber;
        let itemH : CGFloat = itemW
        var index : NSInteger = 0
        for progress in self.progressArray{
            
            let indexX : CGFloat = CGFloat(index % NSInteger(rowNumber))
            let indexY : CGFloat = CGFloat(index / NSInteger(rowNumber))
            let progressV = ProgressView.init(frame: CGRect.init(x: indexX * (itemW + space) + space, y: indexY * (itemH + 20) + navHieght + 20, width: itemW, height: itemW), progress: progress)
            self.view.addSubview(progressV)
            index = index + 1
        }
        
    }
    

}
