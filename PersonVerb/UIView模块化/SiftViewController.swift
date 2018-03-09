//
//  SiftViewController.swift
//  PersonVerb
//
//  Created by GongHua Guo on 2018/2/2.
//  Copyright © 2018年 GongHua Guo. All rights reserved.
//

import UIKit

class SiftViewController: BaseController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let model1 = ItemModel.init()
        model1.title = "满减"
        model1.descriptionStr = "亲爱的小猪，购买商品满16元起送， 配送费4元；实付满49元包邮。详情请致电客服热线：110"
        
        let model2 = ItemModel.init()
        model2.title = "赠品"
        model2.descriptionStr = "精美小礼品， 赠完为止"
        
        let model3 = ItemModel.init()
        model3.title = "优惠"
        model3.descriptionStr = "description: 一件不打折， 两件九五折， 三件九折， 多买多优惠！"
        
        let view = ModelView.init(frame: CGRect.init(x: 10, y: 150, width: SCREENW - 20, height: 20))
        self.view.addSubview(view)
        view.itemArray = [model1, model2, model3]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
