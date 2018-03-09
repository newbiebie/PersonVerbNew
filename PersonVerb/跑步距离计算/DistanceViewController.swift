//
//  DistanceViewController.swift
//  PersonVerb
//
//  Created by GongHua Guo on 2018/1/16.
//  Copyright © 2018年 GongHua Guo. All rights reserved.
//

import UIKit
import CoreLocation



class DistanceViewController: BaseController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    
    //下部展示具体的位置数据的列表
    var tableView : UITableView?
    
    //数据源数组
    var dataArray : NSMutableArray?
    
    //开始时间
    var beginDate : Date?

    //distance
    lazy var distanceLabel : UILabel = {
        let label = UILabel.init(frame: CGRect.init(x: 180, y: navHieght + 50  , width: Int(SCREENW) - 200, height: 30))
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        return label
    }()
    
    //speed
    lazy var speedLabel : UILabel = {
        let label = UILabel.init(frame: CGRect.init(x: 180, y: navHieght + 100  , width: Int(SCREENW) - 200, height: 30))
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        return label
    }()
    
    //beginTime
    lazy var beginTimeLable : UILabel = {
        let label = UILabel.init(frame: CGRect.init(x: 180, y: navHieght + 150  , width: Int(SCREENW) - 200, height: 30))
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        return label
    }()
    
    //runTime
    lazy var runTimeLabel : UILabel = {
        let label = UILabel.init(frame: CGRect.init(x: 180, y: navHieght + 200  , width: Int(SCREENW) - 200, height: 30))
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        return label
    }()
    
    lazy var coder : CLGeocoder = {
        let geo = CLGeocoder.init()
        return geo
    }()
    
    //定位管理器
    var locationManager : CLLocationManager?
    
    var timer : Timer?
    
    //位置数据源
    var locationArray : NSMutableArray?
    
    //移动距离
    lazy var distanceValue = { () -> Measurement<UnitLength> in
        let dis = Measurement.init(value: 0.0, unit: UnitLength.meters)
        return dis
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataArray = NSMutableArray.init()
        self.locationArray = NSMutableArray.init()
        self.getLocationPerson()
        
        self.setUI()
        
        //右侧添加一个按钮
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "开始", style: .done, target: self, action: #selector(self.buttonItemClick(buttonItem:)))
    }
    
    func getLocationPerson() {
        self.locationManager = CLLocationManager.init()
        self.locationManager?.delegate = self
        //定位精度
        self.locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        
        //定位精确度
        self.locationManager?.distanceFilter = kCLDistanceFilterNone
        self.locationManager?.requestAlwaysAuthorization()
        
    }
    
    //右侧开始按钮事件
    @objc func buttonItemClick(buttonItem : UIBarButtonItem) {
        
        //先判断定位权限
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways:
            
            self.locationManager?.startUpdatingLocation()
            
            //记录时间
            self.beginDate = Date.init()
            self.beginTimeLable.text = self.stringFromDate(date: self.beginDate!)
            
            self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { (timer) in
                self.stringFromSecond()
            })
            
        default:
            print("权限设置问题, 重置!!")
            
            let setUrl = NSString.init(string: UIApplicationOpenSettingsURLString)
            if UIApplication.shared.canOpenURL(NSURL.init(string: setUrl as String)! as URL){
                UIApplication.shared.open(NSURL.init(string: setUrl as String)! as URL, options: ["" : ""], completionHandler: nil)
            }
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    //UI布局
    func setUI(){
        
        let titleArray : Array<String> = ["运动距离:", "平均速度:", "开始时间:", "运动时间:"]
        
        //创建 4个标题label
        for i in 0..<4  {
            let label = UILabel.init(frame: CGRect.init(x: 50, y: i * 50 + 50 + navHieght, width: 120, height: 30))
            label.text = titleArray[i]
            label.textAlignment = .center
            label.font = UIFont.boldSystemFont(ofSize: 20.0)
            
            self.view.addSubview(label)
        }
        
        //添加对应label
        self.view.addSubview(self.distanceLabel)
        self.view.addSubview(self.speedLabel)
        self.view.addSubview(self.beginTimeLable)
        self.view.addSubview(self.runTimeLabel)
        
        
        //  添加开始/暂停按钮
        self.tableView = UITableView.init(frame: CGRect.init(x:0 , y: navHieght + 260, width: Int(SCREENW), height:  Int(SCREENH) - (navHieght + 270)))
        self.tableView?.separatorStyle = .none
        self.tableView?.tableFooterView = UIView.init()
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView?.showsVerticalScrollIndicator = false
        self.view.addSubview(self.tableView!)
    }
}


/**相关tableView协议实现*/
extension DistanceViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell.init(style: .subtitle, reuseIdentifier: "cell")
        }
        let dic = self.dataArray![indexPath.row] as! [String : String]
        
        cell?.textLabel?.text = dic["name"]
        cell?.detailTextLabel?.text = dic["isUser"]
        cell?.detailTextLabel?.textColor = .red
        cell?.detailTextLabel?.font = UIFont.boldSystemFont(ofSize: 18.0)
        cell?.textLabel?.numberOfLines = 0
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

/**CLLocationManagerDelegate相关协议处理*/
extension DistanceViewController {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        for item in locations {
            let time = item.timestamp.timeIntervalSinceNow
            if !(item.horizontalAccuracy < 15 && fabs(time) < 10) {
                self.coder.reverseGeocodeLocation(item, completionHandler: { (places, error) in
                    if (places != nil && (error == nil)) {
                        for item1 in places! {
                            let nameStr = NSString.init(format: "%@:%@",item1.addressDictionary!["City"] as! String, item1.addressDictionary!["Name"] as! String)
                            let dic : [String : String] = ["name" : nameStr as String, "isUser" : "无效"]
                            self.dataArray?.add(dic)
                            self.tableView?.reloadData()
                        }
                    }
                })
                
                //直接跳过当前数据
                continue
            }
            
            
            self.coder.reverseGeocodeLocation(item, completionHandler: { (places, error) in
                if (places != nil) {
                    for item1 in places! {
                        
                        let nameStr = NSString.init(format: "%@:%@",item1.addressDictionary!["City"] as! String, item1.addressDictionary!["Name"] as! String)
                        let dic : [String : String] = ["name" : nameStr as String, "isUser" : "有效"]
                        self.dataArray?.add(dic)
                        self.tableView?.reloadData()
                    }
                }
            })
            
            print(self.dataArray?.count as Any)
            
            if self.locationArray!.count > 0 {
                let distance : Double = item.distance(from: self.locationArray!.lastObject as! CLLocation)
                self.distanceValue = Measurement.init(value: distance + self.distanceValue.value, unit:UnitLength.meters)
            }
            self.locationArray?.add(item)
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("定位失败!!!")
    }
}


/**时间 距离 相关计算处理*/
extension DistanceViewController {
    
    //时间转化字符串
    func stringFromDate(date : Date) -> String {
        let formater = DateFormatter.init()
        formater.dateFormat = "HH:MM:SS"
        return formater.string(from: date)
    }
    
    //距离转换
    func stringFromDistance() -> String{
        let formatter = MeasurementFormatter.init()
        return formatter.string(from: self.distanceValue)
    }
    
    //平均速度计算
    func stringFromSecondAndDistance(second : TimeInterval) -> String {
        let formatter = MeasurementFormatter.init()
        formatter.unitOptions = .providedUnit
        let speed = second == 0 ? 0 : self.distanceValue.value / second
        let ment = Measurement.init(value: speed, unit: UnitSpeed.metersPerSecond)
        return formatter.string(from: ment)
    }
    
    //秒数转化时间字符串    系统算法小时最多一个零
    func stringFromSecond() {
        let second = Date.init().timeIntervalSince(self.beginDate!)
        let formater = DateComponentsFormatter.init()
        formater.allowedUnits = [.hour, .minute, .second]
        formater.unitsStyle = .positional
        formater.zeroFormattingBehavior = .pad
        self.runTimeLabel.text = formater.string(from: second)
        self.distanceLabel.text = self.stringFromDistance()
        self.speedLabel.text = self.stringFromSecondAndDistance(second: second)
    }
}


