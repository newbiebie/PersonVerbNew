//
//  LoginViewController.swift
//  PersonVerb
//
//  Created by GongHua Guo on 2018/4/2.
//  Copyright © 2018年 GongHua Guo. All rights reserved.
//

import UIKit


class LoginViewController: BaseCanbackViewController  {
    
    lazy var ListArray : NSMutableArray = {
        let path = Bundle.main.path(forResource:"RongYunList", ofType: ".plist")
        
        let array = NSMutableArray.init(contentsOfFile: path!)
        
        return array!
    }()

    
    //用户账号
    var accountField : UITextField?
    
    //用户密码
    var passwordField : UITextField?
    
    lazy var accountParam : NSDictionary = {
        let param = ["13213185224" : "FaSD8z4x1nXu3B+b6L3IRLI8n4ODaMDw6t7gDNxie9R3h7INegQczkN7DcgebltC1XF8vGOh8vqi0i66u3Kk0iNYKfbi9G72", "12345678" : "irvIIVcF5/3cQORTXMgyw7I8n4ODaMDw6t7gDNxie9R3h7INegQcztgE6rHAimZaa1Y2ao7gJDO1bDJM4Jxga5djDEmRuLZt", "张三" : "ndKmkT9VNbXymiE/t22EVrI8n4ODaMDw6t7gDNxie9R3h7INegQczkkyW/20SnBKdfQTXjhnZfPs/tG2FSBPag==", "李四" : "hPPKPPTF9p1PWoWX3L2EOoYRYlZ4QnmDiKW97AYqs7i8JEtLcVLFVBo8PumNj4xGv2jTy/pe51dI1I+j+254Lw==", "王五" : "cDUDsYwetezEg1fkNXycmLI8n4ODaMDw6t7gDNxie9R3h7INegQczh0CdN08bWXEW2JyXfS5sZLygTfxGZPQgw==", "赵六" : "xyFc9A9TQzFsEu8Dy9FSpYYRYlZ4QnmDiKW97AYqs7i8JEtLcVLFVEqY/NjE0ngwTY9l80M0DAGrJMy2knFEBQ=="  ]
        return param as NSDictionary
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.darkGray
        
        let label : UILabel = UILabel.init()
        self.view.addSubview(label)
        label.text = "融云即时通信"
        label.backgroundColor = .orange
        label.textAlignment = .center
        label.layer.masksToBounds = true
        label.textColor = .white
        label.layer.cornerRadius = 8.0
        label.font = UIFont.systemFont(ofSize: 22.0)
        label.mas_makeConstraints { (maker) in
            maker?.centerX.equalTo()(self.view)
            maker?.top.equalTo()(self.view)?.setOffset(20.0 + CGFloat(navHieght))
            maker?.size.setSizeOffset(CGSize.init(width: 200, height: 50))
        }
        
        let textArray : Array<String> = ["用户名:", "密码:"]
        
        //账号密码按钮
        for index in stride(from: 0, to: 2, by: 1){
            let textLabel = UILabel.init()
            self.view.addSubview(textLabel)
            textLabel.text = textArray[index]
            textLabel.layer.masksToBounds = true
            textLabel.layer.cornerRadius = 5
            textLabel.textAlignment = .center
            textLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
            textLabel.textColor = .orange
            textLabel.mas_makeConstraints({ (maker) in
                maker?.left.equalTo()(self.view)?.setOffset(20.0)
                maker?.top.equalTo()(label.mas_bottom)?.setOffset(CGFloat(80 * index + 80))
                maker?.size.setSizeOffset(CGSize.init(width: 80, height: 30))
            })
        }
        
        //账号文本框layout
        self.accountField = UITextField.init()
        self.view.addSubview(self.accountField!)
        self.accountField?.borderStyle = .roundedRect
        self.accountField?.placeholder = "输入账号/手机号"
        self.accountField?.keyboardType = .numberPad
        self.accountField?.keyboardAppearance = .dark
        self.accountField!.mas_makeConstraints({ (maker) in
            maker?.top.equalTo()(label.mas_bottom)?.setOffset(80)
            maker?.size.setSizeOffset(CGSize.init(width: SCREENW - 200, height: 30))
            maker?.left.equalTo()(self.view)?.setOffset(110.0)
        })
        
        
        let button : UIButton = UIButton.init()
        self.view.addSubview(button)
        
        button.setTitle("选择", for: .normal)
        button.backgroundColor = UIColor.orange
        button.layer.cornerRadius = 5
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17.0)
        button.addTarget(self, action: #selector(self.chanceOneAccount), for: .touchUpInside)
        button.mas_makeConstraints { (maker) in
            maker?.centerY.equalTo()(self.accountField?.mas_centerY)
            maker?.size.setSizeOffset(CGSize.init(width: 60, height: 30))
            maker?.left.equalTo()(self.accountField?.mas_right)?.setOffset(20.0)
        }
        
        
        //密码文本框layout
        self.passwordField = UITextField.init()
        self.view.addSubview(self.passwordField!)
        self.passwordField?.borderStyle = .roundedRect
        self.passwordField?.placeholder = "输入密码"
        self.passwordField?.keyboardType = .numberPad
        self.passwordField?.keyboardAppearance = .dark
        self.passwordField!.mas_makeConstraints { (maker) in
            maker?.top.equalTo()(self.accountField!.mas_bottom)?.setOffset(50)
            maker?.size.setSizeOffset(CGSize.init(width: SCREENW - 200, height: 30))
            maker?.left.equalTo()(self.view)?.setOffset(110.0)
        }
        
        
        let label2 = UILabel.init()
        self.view.addSubview(label2)
        label2.font = UIFont.systemFont(ofSize: 14.0)
        label2.text = "*当前测试状态， 暂时不需要密码，直接输入对应的账号，直接进入聊天界面"
        label2.textColor = UIColor.orange
        label2.numberOfLines = 0
        label2.sizeToFit()
        
        label2.mas_makeConstraints { (maker) in
            maker?.top.equalTo()(self.passwordField?.mas_bottom)?.setOffset(20)
            maker?.centerX.equalTo()(self.view)
            maker?.left.equalTo()(self.view)?.setOffset(30.0)
            maker?.right.equalTo()(self.view)?.setOffset(-30.0)
        }
        
        self.getTokenButtonSet()
        
        
        
        //根据本地存储的数据进行设值
        let titleStr = UserDefaults.standard.object(forKey: "account")
        
        if titleStr != nil {
            self.accountField?.text = titleStr as? String
        }
        else {
            print("为存储到数据！！")
        }
    }
    
    /**
     选择一个账户
     */
    @objc func chanceOneAccount(){
        self.chanceYourAccount()
    }
    
    
    /**
     获取token的按钮
     */
    
    func getTokenButtonSet() {
        let button = UIButton.init()
        self.view.addSubview(button)
        button.addTarget(self, action: #selector(self.getTokenMethod), for: .touchUpInside)
        
        button.backgroundColor = UIColor.orange
        button.setTitle("进入聊天界面", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18.0)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 8.0
        
        button.mas_makeConstraints { (maker) in
            maker?.bottom.equalTo()(self.view.mas_bottom)?.setOffset(-90.0)
            maker?.size.setSizeOffset(CGSize.init(width: 150, height: 40))
            maker?.centerX.equalTo()(self.view)
        }
        
        let label = UILabel.init()
        self.view.addSubview(label)
        label.text = "*输入账号进入对应的聊天界面"
        label.textColor = .orange
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.sizeToFit()
        label.mas_makeConstraints { (maker) in
            maker?.top.equalTo()(button.mas_bottom)?.setOffset(10.0)
            maker?.centerX.equalTo()(self.view)
        }
        
    }
    
    /**
     根据 Token
     */
    @objc func getTokenMethod() {
        
        let titleStr : NSString = NSString.init(string: (self.accountField?.text)!)
        
        if titleStr.length <= 0 {
            self.showAlertInWindow(message: "账号不能为空")
        }
        
        
        let tokenArray : [String] = self.accountParam.allKeys as! [String]
        
        if !tokenArray.contains(self.accountField!.text!) {
            self.showAlertInWindow(message: "请输入正确的账号")
        }
        
        RCIM.shared().initWithAppKey("pvxdm17jp33ir")
        //关联融云服务器
        RCIM.shared().connect(withToken: self.accountParam.object(forKey: self.accountField!.text as Any) as! String, success: { (response) in
            //跳转聊天列表界面
            OperationQueue.main.addOperation({
                
                //跳转会话列表界面讲数据保存下来
                UserDefaults.standard.set(self.accountField!.text, forKey: "account")
                UserDefaults.standard.synchronize()
                
                
                for item in self.ListArray {
                    let param = item as! NSDictionary
                    if (param.object(forKey: "UserID") as! String) == self.accountField!.text! {
                        let userInfo = RCUserInfo.init(userId: param.object(forKey: "UserID") as! String, name: param.object(forKey: "UserName") as! String, portrait: param.object(forKey: "UserPortrait") as! String)
                        RCIM.shared().currentUserInfo = userInfo
                        RCIM.shared().enableMessageAttachUserInfo = true
                    }
                }
                
                let tabVC = MyChatViewController()
                tabVC.title = self.accountField!.text
                self.navigationController?.pushViewController(tabVC, animated: true)
            })
        }, error: { (code) in
            print(code, "关联融云服务器失败")
        }) {
            
        }
    }
    
    func chanceYourAccount(){
        let alertVC = UIAlertController.init(title: "测试", message: "选择自己的账号", preferredStyle: .actionSheet)
        for item  in self.accountParam.allKeys {
            let str = item as! String
            alertVC.addAction(UIAlertAction.init(title: str, style: .default, handler: { (action) in
                self.accountField?.text = action.title
            }))
        }
        alertVC.addAction(UIAlertAction.init(title: "取消", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    func showAlertInWindow(message : String){
        let alertVC = UIAlertController.init(title: nil, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction.init(title: "知道了", style: .destructive, handler: nil))
        self .present(alertVC, animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

   
    
}
