//
//  ArtViewController.swift
//  PersonVerb
//
//  Created by GongHua Guo on 2018/3/7.
//  Copyright © 2018年 GongHua Guo. All rights reserved.
//

import UIKit
class ArtViewController: BaseViewController {

    let imageW = 40
    var timer : Timer?
    
    var questionStr : String = "你认为对你来说现在找一份工作是不是不太容易，或者你很需要这份工作？如果我能给你任何你想要的工作，你会选择什么？你真正想做的是什么工作？请谈谈你个人的最大特色。"
    
    //自定义进度条样式
    var slider : UISlider?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "刷新", style: .plain, target: self, action: #selector(self.rightClick))
//
        
        
        self.dataArray = []
        self.tableView?.backgroundColor = .clear
        self.tableView?.bounces = false
        
        //类型保持一致  swift
        self.tableView?.frame = CGRect.init(x: 0, y: CGFloat(navHieght), width: SCREENW, height: SCREENH - CGFloat(navHieght))
        
        self.tableView?.register(UINib.init(nibName: "ScaleQuestionCell", bundle: nil), forCellReuseIdentifier: "ScaleQuestionCell")
        self.tableView?.register(UINib.init(nibName: "AnswerViewCell", bundle: nil), forCellReuseIdentifier: "AnswerViewCell")

        let button = UIButton.init(frame: CGRect.init(x: 0, y: navHieght - 40, width: 60, height: 30))
        button.setTitle("返回", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18.0)
        button.addTarget(self, action: #selector(self.buttonclicked), for: .touchUpInside)
        
        let button1 = UIButton.init(frame: CGRect.init(x: SCREENW - 90, y: CGFloat(navHieght) - 40, width: 60, height: 30))
        button1.setTitle("刷新", for: .normal)
        button1.titleLabel?.font = UIFont.systemFont(ofSize: 18.0)
        button1.addTarget(self, action: #selector(self.rightClick), for: .touchUpInside)
        
        
        let imgv = UIImageView.init(frame: self.view.bounds)
        imgv.image = UIImage.init(named: "backView")
        
        let imageV1 = UIImageView.init(frame: CGRect.init(x: SCREENW / 2 - 19, y: CGFloat(navHieght) - 39, width: 38, height: 38))
        imageV1.layer.cornerRadius = 19
        imageV1.layer.masksToBounds = true
        imageV1.image = UIImage.init(named: "number03")
        
        self.view .addSubview(imgv)
        self.view.bringSubview(toFront: self.tableView!)
        self.view.addSubview(button)
        self.view.addSubview(button1)
        self.view.addSubview(imageV1)
        self.creatCustomSlider()
        
        /**头像添加一个动画*/
        let rotation = CABasicAnimation.init(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber.init(value: 2 * Double.pi)
        rotation.duration = 4.0
        rotation.repeatCount = MAXFLOAT
        imageV1.layer.add(rotation, forKey: "rotateAnimation")
    }
    
    
    
    @objc func rightClick() {
        self.dataArray = ["心里有光，何惧风浪", "只有决绝的背影，和静默的黑夜。", "一面练习失去，一面不断成长。", "正确"]
        self.tableView?.reloadSections(NSIndexSet.init(index: 1) as IndexSet, with: .top)
    }
    
    /**画一条弧线*/
    func creatCornerLine() {
        
    }

    /**返回按钮点击事件*/
    @objc func buttonclicked(){
        self.navigationController?.popViewController(animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : self.dataArray!.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ScaleQuestionCell") as! ScaleQuestionCell
            cell.content.text = self.questionStr
            cell.textView.text = self.questionStr
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AnswerViewCell") as! AnswerViewCell
            cell.content.text = self.dataArray![indexPath.row] as? String
            let str = NSString.init(string: self.dataArray![indexPath.row] as! String)
            if str.length > 10 {
                cell.content.adjustsFontSizeToFitWidth = true
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let views = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREENW, height: 10))
        views.backgroundColor = .clear
        return views
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        print(SCREENH,  SCREENW)
        
        if indexPath.section == 0 {
            return UITableViewAutomaticDimension
        }
        else {
            return (SCREENH == 667 || SCREENH == 568) ? 60 : 70
        }
    
    }
    
    /**添加进度条样式*/
    func creatCustomSlider() {
        self.slider = UISlider.init(frame: CGRect.init(x: 10, y: navHieght + 10, width: Int(SCREENW) - 20, height: 30))
        self.tableView?.tableHeaderView = self.slider!
        self.slider?.maximumValueImage = UIImage.init(named: "书")
        self.slider?.minimumValueImage = UIImage.init(named: "飞船")
        self.slider?.setThumbImage(UIImage.init(named: "外星人"), for: .normal)
        self.slider?.setMaximumTrackImage(UIImage.init(named: "流星-2")?.resizableImage(withCapInsets: .zero), for: .normal)
        self.slider?.setMinimumTrackImage(UIImage.init(named: "流星")?.resizableImage(withCapInsets: .zero), for: .normal)
        self.slider?.isContinuous = true
        self.slider?.isUserInteractionEnabled = false
        
        var time = 0
        self.timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { (true) in
            time = time + 1
            
            if (time > 1000){
                self.timer?.invalidate()
                self.timer = nil
                return
            }
            self.slider?.setValue(Float(0.001 * Double(time)), animated: true)
        }
        RunLoop.current.add(self.timer!, forMode: .commonModes)
    }
    
    
}
