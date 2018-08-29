//
//  SecretViewController.swift
//  PersonVerb
//
//  Created by GongHua Guo on 2018/1/25.
//  Copyright © 2018年 GongHua Guo. All rights reserved.
//

import UIKit

class SecretViewController: BaseController, UITextFieldDelegate{
    
    
    var keyView : UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let textField = UITextField.init()
        textField.delegate = self
        textField.keyboardType = .numberPad
        textField.keyboardAppearance = .dark
        textField.inputAccessoryView = self.creatHeaderViewForKerboard()
        self.view.addSubview(textField)
        
        textField.becomeFirstResponder()
    }
    
    
    /**创建UI界面*/
    func creatHeaderViewForKerboard() -> UIView {
        
        keyView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREENW, height: 150))
        keyView?.backgroundColor = UIColor.darkGray
        
        let labelWidth = (SCREENW - 70) / 6
        
        //创建显示label
        for i in 0..<6 {
            let lable : UILabel = UILabel.init(frame: CGRect.init(x: CGFloat(i) * (labelWidth + 10) + 10, y: 75 - labelWidth / 2, width: labelWidth, height: labelWidth))
            lable.layer.borderWidth = 1
            lable.layer.borderColor = UIColor.darkGray.cgColor
            lable.tag = 100 + i
            lable.backgroundColor = .white
            lable.textAlignment = .center
            lable.font = UIFont.boldSystemFont(ofSize: 30.0)
            keyView?.addSubview(lable)
        }
        
        //切左上  右上圆角
        let path = UIBezierPath.init(roundedRect: keyView!.bounds, byRoundingCorners: [UIRectCorner.topRight, UIRectCorner.topLeft], cornerRadii: CGSize.init(width: 20, height: 20))
        let maskLayer = CAShapeLayer.init()
        maskLayer.frame = keyView!.bounds
        maskLayer.path = path.cgPath
        keyView?.layer.mask = maskLayer
        
        return keyView!
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension SecretViewController {
    
    /**
     本方法无论输入还是删除都会走一遍
     */
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        //字段范围根据需要设置的密码位数进行设置  位数 -1
        if range.location > 5 {
            return false
        }
        else {
            
            let titleStr = NSString.init(string: textField.text!)
            
            let label = self.keyView?.viewWithTag(100 + range.location) as! UILabel
            
            //输入  密文情况：  直接设置label.text = "*"
            if titleStr.length == range.location {
                print("add")
//                label.text = "*"
            }
                
            //删除
            else if titleStr.length > range.location {
                print("delete")
                
            }
            
            label.text = string
            return true
        }
    }
}
