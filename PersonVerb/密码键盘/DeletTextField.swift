//
//  DeletTextField.swift
//  PersonVerb
//
//  Created by GongHua Guo on 2018/1/25.
//  Copyright © 2018年 GongHua Guo. All rights reserved.
//

import UIKit

protocol DeletTextFieldDelegate {
    func deletedLastItem()
}

class DeletTextField: UITextField {

    //这个也可以获取删除事件
    var Gdelegate : DeletTextFieldDelegate?
    override func deleteBackward() {
        super.deleteBackward()
        self.Gdelegate?.deletedLastItem()
    }

}
