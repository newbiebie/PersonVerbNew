//
//  CustomPickerV.swift
//  PersonVerb
//
//  Created by GongHua Guo on 2018/1/19.
//  Copyright © 2018年 GongHua Guo. All rights reserved.
//

//button宽度
let buttonWidth : CGFloat = 70

//button高度
let buttonHeight : CGFloat = 30

//button距左右的宽度
let leftSpace : CGFloat = 10

//距上
let topSpace : CGFloat = 15

//label  button间距
let labelSpace : CGFloat = 10

//picker和上一个视图之间的距离
let pickerTop = buttonHeight + topSpace * 2




import UIKit

@objc protocol CustomPickeDelegate : NSObjectProtocol {
    
    /**时间选择器选中item*/
    @objc optional func datePcikerSeleted(selectStr : String)
    
    @objc optional func hiddenView()
}

//自定义的视图添加pickerView
class CustomPickerV: UIView, UIPickerViewDelegate, UIPickerViewDataSource{
    
    
    
    //数据源数组
    private var dataArray : Array = [String]()
    
    //选中的行数存放数组
    private var rowSelectArray : Array = [0, 0, 0]
    
    //第二列需要展示的数据
    private var secondRowArray : Array = [Array<String>]()
    
    //第三列需要展示的数据
    private var thirdRowArray : Array = [Array<Array<String>>]()
    //添加在窗体上的视图
    private var backView : UIView = {
        let view : UIView = UIView.init(frame: (UIApplication.shared.keyWindow?.bounds)!)
        view.alpha = 0
        view.backgroundColor = UIColor.init(white: 0.9, alpha: 0.5)
        return view
    }()
    
    private var pickerView : UIPickerView?
    private var datePicker : UIDatePicker?
    
    private var isDatePicker : Bool = false
    
    weak var delegate : CustomPickeDelegate?
    
    private var datePickerMode : UIDatePickerMode?
    
    private var titleLabel : UILabel = {
        let label = UILabel.init(frame: CGRect.init(x: 0, y: 20, width: SCREENW, height: 70));
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.boldSystemFont(ofSize: 25.0)
        label.textColor = .white
        label.backgroundColor = UIColor.init(red: 255.0 / 255.0, green: 127.0 / 255.0, blue: 0.0 / 255.0, alpha: 1)
        return label
    }()

    /**创建三级联动效果, titleArray 第一列数据   secondArray  第二列数据  thirdArray  第三列数据*/
    init(frame: CGRect, titleArray : [String], secondArray : [Array<String>], thirdArray : [Array<Array<String>>],  title : String){
        super.init(frame: frame)
        
        //对应数据源初始化
        self.dataArray = titleArray
        self.secondRowArray = secondArray
        self.thirdRowArray = thirdArray
        
        
        self.setUI(title: title)
        self.addPickerView()
    }
    
    /**根绝传入的mode创建不同类型的时间选择器*/
    init(frame: CGRect, title : String , datePickerMode : UIDatePickerMode) {
        super.init(frame: frame)
        self.isDatePicker = true
        self.datePickerMode = datePickerMode
        self.setUI(title: title)
        self .addDatePicker(pickerMode: datePickerMode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //UI界面布局 初始界面
    func setUI(title : String){
        
        //自身处理
        self.backgroundColor = .white
        self.layer.cornerRadius = 8
        self.layer.shadowOffset = CGSize(width: 5, height: 5)
        self.layer.shadowOpacity = 0.3
        self.layer.shadowColor = UIColor.orange.cgColor
        
        let buttonArray = ["取消", "确定"]
        for i in 0..<2 {
            let button : UIButton = UIButton.init(frame: CGRect.init(x: leftSpace, y: topSpace, width: buttonWidth, height: buttonHeight));
            if i == 1{
                button.frame = CGRect(x: self.bounds.size.width - (buttonWidth + leftSpace), y: topSpace, width: buttonWidth, height: buttonHeight)
            }
            button.setTitle(buttonArray[i], for: .normal)
            button.backgroundColor = .brown
            button.setTitleColor(.white, for: .normal)
            button.layer.cornerRadius = 5
            button.tag = i
            button.addTarget(self, action: #selector(self.buttonClicked(button:)), for: .touchUpInside)
            button.layer.masksToBounds = true
            self.addSubview(button)
        }
        
        //添加标题label
        let label : UILabel = UILabel.init(frame: CGRect.init(x: buttonWidth + leftSpace + labelSpace , y: topSpace, width: self.bounds.size.width - (buttonWidth + leftSpace + labelSpace) * 2, height: buttonHeight))
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.systemFont(ofSize: 15.0)
        label.textColor = .orange
        label.text = title
        label.textAlignment = .center
        self.addSubview(label)
        
    }
    
    
    /**button 的点击事件响应*/
    @objc func buttonClicked(button : UIButton) {
        
        self.hidderInWindow {
            //封闭中进行后续的操作
            self.delegate?.hiddenView?()
            
        }
    }
    
}

/**自定义的UIDatePicker*/
extension CustomPickerV {
    
    /**添加DatePicker*/
    func addDatePicker(pickerMode : UIDatePickerMode) {
        datePicker = UIDatePicker.init(frame: CGRect.init(x: 0, y: pickerTop, width: self.bounds.size.width, height: self.bounds.size.height - pickerTop));
        
        //设置中文格式
        datePicker?.locale = Locale.init(identifier: "zh_CN")
        datePicker?.datePickerMode = pickerMode
        //倒计时模式回转不到零分,  用下面的代码可以换一种取巧实现
//        if pickerMode == .countDownTimer {
//            datePicker?.datePickerMode = .time
//            datePicker?.locale = Locale.init(identifier: "NL")
//        }
        self.datePicker?.setValue(UIColor.orange, forKey: "textColor")
        
        datePicker?.addTarget(self, action: #selector(self.datePickerValueChanged(datePicker:)), for: .valueChanged)
        self.addSubview(datePicker!)
        

    }
    
    /**RunTime获取某一类所有属性*/
    func changeDatePickerTextColor() {
        var count : UInt32 = 0
        let properties = class_copyPropertyList(UIDatePicker.self, &count)
        for i in 0..<Int(count) {
            let property = properties![i]
            let name = property_getName(property)
            let propertyStr = String.init(cString: name)
            print(propertyStr)
            if propertyStr == "textColor" {
                
            }
        }
    }
    
    
    @objc func datePickerValueChanged(datePicker : UIDatePicker) {
        self.titleLabel.text = self.stringFromDate(date: datePicker.date)
    }
    
    func stringFromDate(date : Date) -> String {
        let formater = DateFormatter.init()
        switch self.datePickerMode! {
        case .date:
            formater.dateFormat = "yyyy年M月d日"
        case .time:
            formater.amSymbol = "上午"
            formater.pmSymbol = "下午"
            formater.dateFormat = "aa hh:mm"
        case .dateAndTime:
            formater.amSymbol = "上午"
            formater.pmSymbol = "下午"
            formater.dateFormat = "M月d日 eee aa hh:mm"
            
        default:
            formater.dateFormat = "HH 小时 mm 分钟"
        }
        
        return formater.string(from: date)
    }
}

/**UIPickerViewDelegate  UIPickerViewDataSource  协议实现*/
extension CustomPickerV {
    
    /**添加pickerView*/
    func addPickerView() {
        pickerView = UIPickerView.init(frame: CGRect.init(x: 0, y: pickerTop, width: self.bounds.size.width, height: self.bounds.size.height - pickerTop))
        pickerView?.delegate = self
        pickerView?.dataSource = self
        pickerView?.showsSelectionIndicator = true
        self.addSubview(pickerView!)
    }
    
    //列数
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    //对应列对应行数
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if component == 0 {
            return self.dataArray.count
        }
        else if (component == 1) {
            return self.secondRowArray[self.rowSelectArray[0]].count
        }
        else {
            return self.thirdRowArray[self.rowSelectArray[0]][self.rowSelectArray[1]].count
        }
    }
    
    //每一列对应的标题
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return self.dataArray[row]
        }
        else if component == 1 {
            return self.secondRowArray[self.rowSelectArray[0]][row]
        }
        else {
            return self.thirdRowArray[self.rowSelectArray[0]][self.rowSelectArray[1]][row]
        }
        
    }
    
    //选中行数
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.rowSelectArray[component] = row
        if component == 0 {
            self.rowSelectArray[1] = 0
            self.rowSelectArray[2] = 0
            self.pickerView?.selectRow(0, inComponent: 1, animated: false)
            self.pickerView?.selectRow(0, inComponent: 2, animated: false)
           
        }
        else if component == 1 {
            self.rowSelectArray[2] = 0
            self.pickerView?.selectRow(0, inComponent: 2, animated: false)
            
        }
        self.pickerView?.reloadAllComponents()
        
        self.setTextForTitleLabel()
    }
    
    /**为titleLabel设置字体*/
    func setTextForTitleLabel() {
        let first = self.rowSelectArray[0]
        let seond = self.rowSelectArray[1]
        let third = self.rowSelectArray[2]
        
        self.titleLabel.text = NSString.init(format: "%@  %@  %@", self.dataArray[first], self.secondRowArray[first][seond], self.thirdRowArray[first][seond][third]) as String
    }
    //设置每行的高度
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 45
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        var label = view as? UILabel
        
        
        
        if label == nil {
            label = UILabel.init()
        }
        label?.textAlignment = .center
        label?.adjustsFontSizeToFitWidth = true
        label?.font = UIFont.systemFont(ofSize: 15.0)
        label?.textColor = .orange
        label?.text = self.pickerView(pickerView, titleForRow: row, forComponent: component)
        
        
    //根据不同的列不同的行设置字体颜色 大小
        if self.rowSelectArray[component] == row {
            label?.textColor = .red
            label?.font = UIFont.boldSystemFont(ofSize: 16.0)
        }
        return label!;
    }
}



/**展示和隐藏的方法*/
extension CustomPickerV {
    
    /**添加一个展示的方法   添加在窗体上  遮盖其他按钮的点击事件*/
    func showInWindow() {
        
        
        //进行一个缩放效果处理
        OperationQueue.main.addOperation {
            self.layer.transform = CATransform3DMakeScale(0.0, 0.0, 0.0)
            self.backView.addSubview(self)
            self.center = self.backView.center
            UIApplication.shared.keyWindow?.addSubview(self.backView)
            UIView.animate(withDuration: 0.4) {
                self.layer.transform = CATransform3DMakeScale(1.0, 1.0, 1.0)
                self.backView.alpha = 1
                self.backView.addSubview(self.titleLabel)
                if self.isDatePicker {
                    self.titleLabel.text = self.stringFromDate(date: self.datePicker!.date)
                }
                else {
                    self.setTextForTitleLabel()
                }
            }
        }
    }
    
    /**隐藏*/
    func hidderInWindow(complection : @escaping (() -> ())) {
        
        UIView.animate(withDuration: 1, animations: {
            self.backView.alpha = 0
        }) { (yes) in
            self.backView.removeFromSuperview()
            
            OperationQueue.main.addOperation({
                complection()
            })
        }
    }
}
