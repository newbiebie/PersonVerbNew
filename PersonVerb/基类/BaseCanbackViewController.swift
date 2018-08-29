//
//  BaseCanbackViewController.swift
//  PersonVerb
//
//  Created by GongHua Guo on 2018/8/29.
//  Copyright © 2018年 GongHua Guo. All rights reserved.
//

import UIKit

class BaseCanbackViewController: BaseController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.creatBackButton()
    }

    func creatBackButton(){
        self.navigationItem.hidesBackButton = true
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "返回-3"), style: .plain, target: self, action: #selector(self.backButtonAction))
    }
    
    @objc func backButtonAction(){
        self.navigationController?.popViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
