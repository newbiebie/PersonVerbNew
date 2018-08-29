//
//  PostscriptViewController.swift
//  PersonVerb
//
//  Created by GongHua Guo on 2018/8/29.
//  Copyright © 2018年 GongHua Guo. All rights reserved.
//

import UIKit

class PostscriptViewController: BaseController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = UIColor.gray
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
}
