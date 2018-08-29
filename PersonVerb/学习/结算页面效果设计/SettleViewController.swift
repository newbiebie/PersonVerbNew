//
//  SettleViewController.swift
//  SwiftExercise
//
//  Created by xunji on 2018/5/24.
//  Copyright © 2018年 xunji. All rights reserved.
//

import UIKit

class SettleViewController: BaseCanbackViewController {

    var bottomNumber : NSInteger = 5
    
    //底部推广列表
    var scrollView : UIScrollView?
    
    
    //效果视图控件
    var layerView : UIView?
    
    //中间两个展示用的控件
    var moneyTitle : UICountingLabel?
    var tipLabel : UILabel?
    
    //展示成功还是失败控件
    var sucessLabel : UILabel?
    
    var backView : UIView?
    //定义label需要现实的文字数值
    var labeltext = 85.15

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "结算页面效果设计"
        self.addTopView()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(self.rightButtonClicked(barItem:)))
    }
    
    
    /**
     右侧按钮的点击事件响应
     */
    @objc func rightButtonClicked(barItem : UIBarButtonItem) {
        
        self.backView = UIView.init(frame: UIApplication.shared.keyWindow!.bounds)
        self.backView?.backgroundColor = UIColor.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.3)
        
        let tap : UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(self.viewTap(gesture:)))
        self.backView?.addGestureRecognizer(tap)
        
        UIApplication.shared.keyWindow?.addSubview(self.backView!)
        self.verizAnimation()
    }
    
    @objc func viewTap(gesture : UIGestureRecognizer) {
        if gesture.state == .ended {
            gesture.view!.removeFromSuperview()
        }
    }
    
    /**波浪   -->  纵向动画*/
    func verizAnimation(){
        
        
        //在指定位置添加固定数量的按钮
        //标题label
        let titleArray : Array<String> = ["10", "20", "30", "40", "50", "60"]
        
        
        //item之间的间距
        let space : CGFloat = 10
        
        
        //item尺寸
        let itemHeight : CGFloat = 50
        
        
        //固定的起始位置
        let beginPointY : CGFloat = navHieght
        
        let centerX : CGFloat = SCREENW - 28
        
        //buttonArray  方便执行动画
        let buttonArray : NSMutableArray = NSMutableArray.init()
        var arrayIndex = 0
        
        
        for item in titleArray{
            
            let button = UIButton.init(frame: CGRect.init(x: beginPointY - itemHeight / 2, y: beginPointY - itemHeight, width: itemHeight, height: itemHeight))
            button.setTitle(item, for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20.0)
            button.layer.borderWidth = 2.0
            button.backgroundColor = .orange
            button.layer.borderColor = UIColor.gray.cgColor
            button.layer.cornerRadius = itemHeight / 2
            button.layer.masksToBounds = true
            button.addTarget(self, action: #selector(self.iconButtonClicked(button:)), for: .touchUpInside)
            button.isHidden = true
            button.tag = arrayIndex + 500
            self.backView!.addSubview(button)
            buttonArray.add(button)
            arrayIndex = arrayIndex + 1
        }
        
        
        //动画执行时间
        let timeDurtion = 1.0
        
        
        //起始Y轴中心点
        let beginCenterY = beginPointY - itemHeight / 2
        
        
        //动画执行
        buttonArray.enumerateObjects { (lable, index, stop) in
            
            let newIndex = buttonArray.count - index - 1
            let button = buttonArray[newIndex] as! UIButton
            button.isHidden = false
            
            
            //时间分段
            let time = timeDurtion / Double(buttonArray.count)
            
            
            let scale = 0.1 * Double(buttonArray.count - index) + 0.4
            
            
            var sum = 0
            for i in 0...newIndex{
                sum = sum + i + 5
            }
            let centerY = navHieght + CGFloat(newIndex + 1) * space + CGFloat(sum) * itemHeight * 0.1
            //位移动画
            let animationPostion = CABasicAnimation.init(keyPath: "position")
            animationPostion.fromValue = NSValue.init(cgPoint: CGPoint.init(x: centerX, y: beginCenterY))
            animationPostion.toValue = NSValue.init(cgPoint: CGPoint.init(x: centerX, y: centerY))
            
            animationPostion.duration = time
            animationPostion.fillMode = kCAFillModeForwards
            animationPostion.isRemovedOnCompletion = false
            animationPostion.beginTime = CACurrentMediaTime()
            button.layer.add(animationPostion, forKey: "group")
            
            
            //缩放动画
            let animationScale = CABasicAnimation.init(keyPath: "transform.scale")
            animationScale.duration = time * (Double(index) + 2)
            animationScale.fromValue = scale
            animationScale.toValue = scale
            animationScale.fillMode = kCAFillModeForwards
            animationScale.isRemovedOnCompletion = false
            animationScale.beginTime = CACurrentMediaTime()
            button.layer.add(animationScale, forKey: "scale")
            
            
            //等动画结束后，改变按钮真正位置
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.init(uptimeNanoseconds: UInt64(timeDurtion)), execute: {
                button.center = CGPoint.init(x: centerX, y: centerY)
            })
        }
    }
    
    
    /**
     效果添加
     */
    func addTopView() {
        
        let topView = UIView.init()
        topView.backgroundColor = UIColor.darkGray
        self.view.addSubview(topView)
        topView.mas_makeConstraints { (maker) in
            maker?.left.equalTo()(self.view)
            maker?.right.equalTo()(self.view)
            maker?.top.equalTo()(self.view)?.offset()(navHieght)
            maker?.height.offset()(self.scaleFromWidth(value: 200))
        }
        
        self.layerView = UIView.init()
        self.view.addSubview(self.layerView!)
        self.layerView?.layer.cornerRadius = self.scaleFromWidth(value: 8);
        self.layerView?.layer.borderWidth = 0.5
        self.layerView?.layer.borderColor = UIColor.gray.cgColor
        self.layerView?.backgroundColor = UIColor.white
        self.layerView?.layer.shadowColor = UIColor.red.cgColor
        self.layerView?.layer.shadowOffset = CGSize.init(width: 8, height: 8)
        self.layerView?.layer.shadowOpacity = 0.3
        
        self.layerView!.mas_makeConstraints { (maker) in
            maker?.top.equalTo()(topView.mas_bottom)?.offset()(-(self.scaleFromWidth(value: 100)))
            maker?.size.setSizeOffset(CGSize.init(width: SCREENW * 0.85, height: self.scaleFromWidth(value: 200)))
            maker?.centerX.equalTo()(self.view)
        }
        
        self.layoutSubViewsForTopView()
        
    }
    
    
    /**
     卡片内内容布局样式
     */
    func layoutSubViewsForTopView(){
        
        //添加一个头像Icon
        let imageView = UIImageView.init()
        self.view.addSubview(imageView)
        imageView.image = UIImage.init(named: "iconImage")
        let imageWidth = self.scaleFromWidth(value: 80.0)
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = imageWidth / 2
        
        imageView.mas_makeConstraints { (maker) in
            maker?.top.equalTo()(self.view)?.offset()(navHieght + self.scaleFromWidth(value: 10.0))
            maker?.centerX.equalTo()(self.view)
            maker?.size.setSizeOffset(CGSize.init(width: imageWidth, height: imageWidth))
        }
        
        //定义金钱显示控件
        self.moneyTitle = UICountingLabel.init()
        self.layerView?.addSubview(self.moneyTitle!)
        
        self.moneyTitle?.text = "0"
        self.moneyTitle?.textColor = .orange
        self.moneyTitle?.format = "%.2f%"
        self.moneyTitle?.method = .easeInOut
        self.moneyTitle?.font = UIFont.boldSystemFont(ofSize: self.scaleFromWidth(value: 60.0))
        self.moneyTitle!.mas_makeConstraints { (maker) in
            maker?.top.equalTo()(self.layerView!)?.offset()(self.scaleFromWidth(value: 30.0))
            maker?.centerX.equalTo()(self.layerView!)
        }
        
        //添加一个后缀
        let label = UILabel.init()
        label.text = "元"
        label.textColor = .red
        label.font = UIFont.boldSystemFont(ofSize: self.scaleFromWidth(value: 12.0))
        self.layerView?.addSubview(label)
        label.mas_makeConstraints { (maker) in
            maker?.bottom.equalTo()(self.moneyTitle!.mas_bottom)?.offset()(-10)
            maker?.left.equalTo()(self.moneyTitle!.mas_right)?.offset()(3.0)
        }
        
        //定义提示文字
        self.tipLabel = UILabel.init()
        self.layerView?.addSubview(self.tipLabel!)
        
        self.tipLabel?.text = "*Tips: 获取金钱达到一定下线可以在钱包中提现"
        self.tipLabel?.textColor = .red
        self.tipLabel?.font = UIFont.systemFont(ofSize: self.scaleFromWidth(value: 14.0))
        self.tipLabel?.textAlignment = .center
        self.tipLabel?.numberOfLines = 2
        
        self.tipLabel!.mas_makeConstraints { (maker) in
            maker?.top.equalTo()(self.moneyTitle!.mas_bottom)?.offset()(self.scaleFromWidth(value: 30.0))
            maker?.left.equalTo()(self.layerView!)?.offset()(self.scaleFromWidth(value: 15.0))
            maker?.right.equalTo()(self.layerView!)?.offset()(-(self.scaleFromWidth(value: 15.0)))
        }
    }
    
    
    //定义sucessLabel位置
    func layoutSucessLabel(){
        
        let middleView = UIView.init()
        self.view.addSubview(middleView)
        
        middleView.mas_makeConstraints { (maker) in
            maker?.top.equalTo()(self.layerView!.mas_bottom)
            maker?.bottom.equalTo()(self.scrollView!.mas_top)
            maker?.left.equalTo()(self.view)
            maker?.right.equalTo()(self.view)
        }
        
        let bottomLabel = UILabel.init()
        middleView.addSubview(bottomLabel)
        
        bottomLabel.text = "Sucess!"
        bottomLabel.font = UIFont.boldSystemFont(ofSize: self.scaleFromWidth(value: 60.0))
        bottomLabel.mas_makeConstraints { (maker) in
            maker?.center.equalTo()(middleView)
        }
        
        self.sucessLabel = UILabel.init()
        bottomLabel.addSubview(self.sucessLabel!)
        
        self.sucessLabel?.text = "Sucess!"
        self.sucessLabel?.textColor = .orange
        self.sucessLabel?.font = UIFont.boldSystemFont(ofSize: self.scaleFromWidth(value: 60.0))
        
        self.sucessLabel!.mas_makeConstraints { (maker) in
            maker?.center.equalTo()(bottomLabel.center)
        }
        
        middleView.layoutIfNeeded()
        
        
        self.animationLabel(label: bottomLabel)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.layoutScrollView()
        
        self.moneyTitle!.count(from: 0, to: CGFloat(self.labeltext), withDuration: 1.0)
    }
    
    /**
     底部列表布局
     */
    func layoutScrollView(){
        
        self.scrollView = UIScrollView.init()
        self.view.addSubview(self.scrollView!)
        
        //定义底部广告 一屏展示的个数
        let tipNumber = 3
        
        //控件间间隙
        let  itemSpace = 15
        
        //scrollView距离两侧的边距
        let scrollSpace : CGFloat = 0
        
        //定义控件的宽度
        let tipItemWidth = (Int(SCREENW - 2 * scrollSpace) - (tipNumber + 1) * itemSpace) / tipNumber
        let tipItemHeight = Double(tipItemWidth) * 1.5
        
        let index = self.bottomNumber >= 3 ? 3 : self.bottomNumber
        
        self.scrollView!.mas_makeConstraints({ (maker) in
            maker?.centerX.equalTo()(self.view)
            maker?.width.offset()(CGFloat(index * (tipItemWidth + itemSpace) + itemSpace))
            maker?.bottom.equalTo()(self.view)?.offset()(-(bottomHeight + 30))
            maker?.height.offset()(CGFloat(tipItemHeight))
        })
        
        //调用布局获取layout之后的frame  不调用为0
        self.view.layoutIfNeeded()
        self.scrollView?.showsHorizontalScrollIndicator = false
        self.scrollView?.contentSize = CGSize.init(width: self.bottomNumber * (itemSpace + tipItemWidth) + itemSpace, height: 0)
        
        for i in 0..<self.bottomNumber {
            let imageItem = TitleImage.init(frame: CGRect.init(x: i * (tipItemWidth + itemSpace) + itemSpace, y: 0, width: tipItemWidth, height: Int(tipItemHeight)))
            imageItem.imageView?.backgroundColor = .orange
            self.scrollView?.addSubview(imageItem)
        }
        
        
        self.layoutSucessLabel()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    //为成功的标签添加一个动画效果
    /**文字的动画效果*/
    func animationLabel(label : UILabel){
        
        //创建CAGradientLayer对象
        let gradientLayer = CAGradientLayer()
        //设置初始渐变色
        gradientLayer.colors = [UIColor.orange.cgColor,
                                UIColor.green.cgColor,
                                UIColor.orange.cgColor]
        //设置每种颜色初始所在的位置
        gradientLayer.locations = [0, 0, 0.25]
        //设置渲染的起始结束位置（横向渐变）
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        //设置其CAGradientLayer对象的frame，并插入view的layer
        gradientLayer.frame = CGRect.init(x: 0, y: 0, width: label.frame.size.width, height: label.frame.size.height);
        //将渐变层添加到文本标签背景上
        label.layer.insertSublayer(gradientLayer, at: 0)
        let gradientAnimation = CABasicAnimation(keyPath: "locations")
        gradientAnimation.fromValue = [0, 0, 0.5]
        gradientAnimation.toValue = [0.8, 1, 1]
        gradientAnimation.duration = 2
        //动画一致重复执行
        gradientAnimation.repeatCount = HUGE
        gradientLayer.add(gradientAnimation, forKey: nil)
        //设置遮罩，让渐变层透过文字显示出来
        label.mask = self.sucessLabel!
    }
    
    /**头像点击出现控件点击事件*/
    @objc func iconButtonClicked(button : UIButton){
        
        self.backView!.removeFromSuperview()
        self.nextWork(index: button.tag - 500)
    }
    
    
    /**根据传递过来的值进行下一步操作*/
    func nextWork(index : NSInteger) {
        
        let lastValue = self.labeltext
        switch index {
        case 0:
            self.labeltext = self.labeltext + 10
        case 1:
            self.labeltext = self.labeltext + 20
        case 2:
            self.labeltext = self.labeltext + 30
        case 3:
            self.labeltext = self.labeltext + 40
        case 4:
            self.labeltext = self.labeltext + 50
        default:
            self.labeltext = self.labeltext + 60
        }
        
        self.moneyTitle!.count(from: CGFloat(lastValue), to: CGFloat(self.labeltext), withDuration: 1.0)
    }
    

}
