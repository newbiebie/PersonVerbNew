//
//  MyChatViewController.swift
//  PersonVerb
//
//  Created by GongHua Guo on 2018/4/8.
//  Copyright © 2018年 GongHua Guo. All rights reserved.
//

import UIKit


class MyChatViewController: RCConversationListViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.conversationListTableView.tableFooterView = UIView.init()
        
        self.setDisplayConversationTypes([RCConversationType.ConversationType_PRIVATE.rawValue, RCConversationType.ConversationType_DISCUSSION.rawValue, RCConversationType.ConversationType_CHATROOM.rawValue, RCConversationType.ConversationType_GROUP.rawValue, RCConversationType.ConversationType_APPSERVICE.rawValue, RCConversationType.ConversationType_SYSTEM.rawValue])
        //设置需要将哪些类型的会话在会话列表中聚合显示
        self.setCollectionConversationType([RCConversationType.ConversationType_DISCUSSION.rawValue, RCConversationType.ConversationType_GROUP.rawValue])
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .bookmarks, target: self, action: #selector(self.backAction))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(self.addFriend))

        
        
        
        
    }
    
    @objc func backAction() {
        self.navigationController?.popViewController(animated: true)
        RCIM.shared().disconnect()
    }
    
    //开启单聊界面
    @objc func addFriend() {
        let alertVC = UIAlertController.init(title: "开启单聊会话", message: nil, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction.init(title: "确定", style: .destructive, handler: { (action) in
            OperationQueue.main.addOperation({
                self.jumpChatController(type: RCConversationType.ConversationType_PRIVATE, id: (alertVC.textFields?.last?.text)!, title: (alertVC.textFields?.last?.text)!)
            })
        }))
        alertVC.addTextField { (field) in
            field.placeholder = "请输入对应的账号"
        }
        alertVC.addAction(UIAlertAction.init(title: "取消", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func onSelectedTableRow(_ conversationModelType: RCConversationModelType, conversationModel model: RCConversationModel!, at indexPath: IndexPath!) {
        self.jumpChatController(type: model.conversationType, id: model.targetId, title: model.targetId)
    }
    
    //跳转单聊界面
    func jumpChatController(type : RCConversationType, id : String, title : String){
        let vc = RCConversationViewController()
        vc.conversationType = type
        vc.targetId = id
        vc.title = title
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
