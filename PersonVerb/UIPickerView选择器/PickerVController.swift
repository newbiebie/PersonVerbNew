//
//  PickerVController.swift
//  PersonVerb
//
//  Created by GongHua Guo on 2018/1/19.
//  Copyright © 2018年 GongHua Guo. All rights reserved.
//


//尝试构建各种形式的pickerView
import UIKit

class PickerVController: BaseViewController, CustomPickeDelegate {
    
    /**UIDatePickerMode数组*/
    let modeArray : Array<UIDatePickerMode> = [UIDatePickerMode.time, UIDatePickerMode.date, UIDatePickerMode.dateAndTime, UIDatePickerMode.countDownTimer]
    //三级联动, 最外层数据
    lazy var ListArray : NSMutableArray = {
        let path = Bundle.main.path(forResource:"Address", ofType: ".plist")
        
        let array = NSMutableArray.init(contentsOfFile: path!)
        
        return array!
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataArray = ["省市区三级联动", "时间选择器 = Time", "时间选择器 = Date", "时间选择器 = DateAndTime", "时间选择器 = CountDownTimer"]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    //视图已经展现
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cellBuuton")
        if cell == nil {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: "cellButton")
        }
        let button = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: SCREENW * 0.8, height: 60))
        button.setTitle(self.dataArray![indexPath.row] as? String, for: .normal)
        button.backgroundColor = .orange
        button.layer.cornerRadius = 8
        button.center = CGPoint.init(x: SCREENW / 2, y: 50)
        cell?.contentView.addSubview(button)
        //关闭交互处理, 点击事件才能透传到cell上
        button.isUserInteractionEnabled = false
        cell?.selectionStyle = .none
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    
}

/**点击事件相关处理*/ 
extension PickerVController {
    
    /**处于简单化, 事件放在cell上*/
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if !(self.tableView?.isUserInteractionEnabled)! {
            return
        }
        
        self.tableView?.isUserInteractionEnabled = false
        
        switch indexPath.row {
        case 0:
            self .cityShow()
        default:
            self.datePickerShow(row: indexPath.row - 1)
        }
    }
    
    /**省市区三级联动*/
    func cityShow() {
        var array1 = NSMutableArray.init() as! [String]
        var array2 = NSMutableArray.init() as! [Array<String>]
        var array3 = NSMutableArray.init() as! [Array<Array<String>>]
        for item in self.ListArray {
            let dic = item as! NSDictionary
            array1.append(dic.allKeys[0] as! String)
            
            for item1 in dic.allValues {
                let dic2 = item1 as! NSDictionary
                array2.append(dic2.allKeys as! Array<String>)
                array3.append(dic2.allValues as! Array<Array<String>>)
            }
        }
        
        let picker : CustomPickerV = CustomPickerV.init(frame: CGRect.init(x: 0, y: 0, width: SCREENW * 0.9, height: SCREENH * 0.5), titleArray: array1, secondArray: array2, thirdArray: array3, title: "省市区三级联动")
        picker.showInWindow()
    }
    
    /**时间选择器*/
    func datePickerShow(row : Int) {
        let picker = CustomPickerV.init(frame: CGRect.init(x: 0, y: 0, width: SCREENW * 0.9, height: SCREENH * 0.5), title: self.dataArray![row + 1] as! String, datePickerMode: self.modeArray[row])
        picker.delegate = self
        picker.showInWindow()
    }
    
    /**CustomPickeDelegate相关方法选择性实现*/
    func hiddenView() {
        print("搞定")
        self.tableView?.isUserInteractionEnabled = true
    }
    
    
    
}
