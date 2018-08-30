//
//  ListModel.swift
//  PersonVerb
//
//  Created by GongHua Guo on 2018/8/30.
//  Copyright © 2018年 GongHua Guo. All rights reserved.
//

import UIKit

// MARK: swift 4.0的缘故， 在属性前添加 @objc  或者  在类名前添加@objc，  否则无法从字典数组中获取到数据

class ListModel: NSObject {

    /**名称*/
    @objc var title : String = ""
    
    /**
     是否最终节点  判断图片  以及展示效果
     */
    @objc var isRoot : Bool = false
    
    /**层级*/
    @objc var rowNumber : CGFloat = 0
    
    /**开关*/
    @objc var isOpen : Bool = false
    
    /**模型列表*/
    @objc var modelList : Array = [NSDictionary]()
    
    @objc var listType : CGFloat = 0
}
