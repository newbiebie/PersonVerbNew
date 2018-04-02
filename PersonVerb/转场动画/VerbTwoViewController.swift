//
//  VerbTwoViewController.swift
//  PersonVerb
//
//  Created by GongHua Guo on 2018/3/20.
//  Copyright © 2018年 GongHua Guo. All rights reserved.
//

import UIKit

class VerbTwoViewController: VerbViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.label.text = "这个是二维码界面"
        self.view.backgroundColor = .lightGray
        
        self.leftButton?.isEnabled = true
        self.rightButton?.isEnabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

    

}
