//
//  ViewController.swift
//  PersonVerb
//
//  Created by GongHua Guo on 2018/1/10.
//  Copyright © 2018年 GongHua Guo. All rights reserved.
//

import UIKit

public enum DeviceType: Int {
    case simulator
    case appleTV
    case appleTV4K
    case homePod
    
    case iPod1
    case iPod2
    case iPod3
    case iPod4
    case iPod5
    
    case iPad2
    case iPad3
    case iPad4
    case iPad5
    case iPadAir1
    case iPadAir2
    
    case iPadMini1
    case iPadMini2
    case iPadMini3
    case iPadMini4
    
    case iPadPro9_7
    case iPadPro12_9
    case iPadPro10_5
    
    case iPhone4
    case iPhone4S
    case iPhone5
    case iPhone5C
    case iPhone5S
    case iPhoneSE
    case iPhone6
    case iPhone6plus
    case iPhone6S
    case iPhone6Splus
    case iPhone7
    case iPhone7plus
    case iPhone8
    case iPhone8plus
    case iPhoneX
    case unrecognized
}


class ViewController: BaseViewController , LoadScrollViewDelegate, UINavigationControllerDelegate {
    
    //闪屏
    var scrollView : LoadScrollView?
    
    //类名字符串数组
    let classArray : Array<String> = ["CollectionViewController", "DistanceViewController", "RotationViewController", "PickerVController", "SecretViewController", "MYNavgViewController", "SiftViewController", "ArtViewController", "AnimationViewController"
    ]
    
    //闪屏广告图片数组
    let array : Array<NSString> = ["number01", "number02", "number03"]
    
    //可以在这个页面添加一个广告视图, 具体类型自己设置,方便添加点击事件处理
    func creatScrollViewForNoun(){
        self.scrollView = LoadScrollView.init(frame: CGRect.init(x: 0, y: 0, width: SCREENW, height: SCREENH))
        self.scrollView?.imageArray = self.array
        self.scrollView?.creatU()
        self.scrollView?.ItemDelegate = self
        UIApplication.shared.keyWindow!.addSubview(self.scrollView!)
        
        
        let label = UILabel.init()
        label.font = UIFont.boldSystemFont(ofSize: 25.0)
        label.text = NSString.init(format: "设备型号: %@", UIDevice.current.modelName) as String
        label.sizeToFit()
        label.textColor = .red
        label.center = CGPoint.init(x: SCREENW / 2, y: 150)
        self.scrollView?.addSubview(label)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //父类属性
        self.dataArray = NSMutableArray.init(array: ["UICollectionViewCell重排", "跑步距离计算", "UICollectionView旋转布局", "UIPickerView选择器", "密码键盘", "自定义导航", "UIView模块化","问答系统", "头像动画"])
        
        
        
        self.creatScrollViewForNoun()
        self.navigationController?.delegate = self
        
        self.textColor = UIColor.black
        self.fontSize = 18.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell");
        if (cell == nil) {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: "cell")
        }
        cell?.selectionStyle = .none
        cell?.accessoryType = .disclosureIndicator
        cell?.textLabel?.text = self.dataArray?[indexPath.row] as? String
        return cell!;
    }
   
    
}

/*相关的协议事件方法在扩展中**/
extension ViewController {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        OperationQueue.main.addOperation {
            let vc : UIViewController = self.creatViewControllerFromStr(classStr: self.classArray[indexPath.row])
            vc.title = self.dataArray?[indexPath.row] as? String
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    //通过字符串创建一个类
    func creatViewControllerFromStr(classStr : String) -> (UIViewController){
        let namespace = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
        //注意工程中必须有相关的类，否则程序会crash
        let vcClass : AnyObject = NSClassFromString(namespace + "." + classStr)!
        // 告诉编译器它的真实类型
        let viewControllerClass = vcClass as! UIViewController.Type
        return viewControllerClass.init()
    }
}

/**LoadScrollView相关协议实现*/
extension ViewController {
    /**闪屏页面跳过按钮事件*/
    func buttonSelected() {
        
        if (self.scrollView != nil) {
            self.HandleHSomething {
            }
        }
    }
    
    /**闪屏页面图片被点击事件响应*/
    func imageSelected(item: NSInteger) {
        
        if (self.scrollView != nil) {
            self.HandleHSomething {
                OperationQueue.main.addOperation({
                    //这一步可以进行一些对应的操作
                    let alertVC = UIAlertController.init(title: "事件提醒", message: NSString.init(format: "你选择了第%d张图片\n图片名称是:%@", item, self.array[item]) as String, preferredStyle: .alert)
                    alertVC.addAction(UIAlertAction.init(title: "取消", style: .destructive, handler: { (action) in
                    }))
                    self.present(alertVC, animated: true, completion: nil)
                })
            }
        }
    }
    
    /**包装函数简洁实现*/
    func HandleHSomething(completionBlock : @escaping () -> ()){
        UIView.animate(withDuration: 1.5, animations: {
            self.scrollView?.alpha = 0.0
        }, completion: { (isAlready) in
            self.scrollView?.removeFromSuperview()
            completionBlock();
        })
    }
}

// MARK: UINavgationController 指定控制不显示导航
extension ViewController {
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        
        if viewController.isKind(of: MYNavgViewController.self) || viewController.isKind(of: ArtViewController.self) {
            self.navigationController?.navigationBar.isHidden = true;
        }
        else {
            self.navigationController?.navigationBar.isHidden = false
        }
    }
}


// MRAK UIDevice的设备型号扩展
extension UIDevice {
    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        switch identifier {
        case "iPod1,1":                                  return "iPod Touch 1"
        case "iPod2,1":                                  return "iPod Touch 2"
        case "iPod3,1":                                  return "iPod Touch 3"
        case "iPod4,1":                                  return "iPod Touch 4"
        case "iPod5,1":                                  return "iPod Touch 5"
        case "iPod7,1":                                  return "iPod Touch 6"
            
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4": return "iPad 2"
        case "iPad3,1", "iPad3,2", "iPad3,3":            return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6":            return "iPad 4"
        case "iPad6,11", "iPad6,12":                     return "iPad 5"
        case "iPad4,1", "iPad4,2", "iPad4,3":            return "iPad Air 1"
        case "iPad5,3", "iPad5,4":                       return "iPad Air 2"
        case "iPad2,5", "iPad2,6", "iPad2,7":            return "iPad Mini 1"
        case "iPad4,4", "iPad4,5", "iPad4,6":            return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":            return "iPad Mini 3"
        case "iPad5,1", "iPad5,2":                       return "iPad Mini 4"
        case "iPad6,3", "iPad6,4":                       return "iPad Pro 9.7 Inch"
        case "iPad6,7", "iPad6,8":                       return "iPad Pro 12.9 Inch"
        case "iPad7,1", "iPad7,2":                       return "iPad Pro 12.9 Inch 2.Generation"
        case "iPad7,3", "iPad7,4":                       return "iPad Pro 10.5 Inch"
            
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":      return "iPhone 4"
        case "iPhone4,1":                                return "iPhone 4s"
        case "iPhone5,1", "iPhone5,2":                   return "iPhone 5"
        case "iPhone5,3", "iPhone5,4":                   return "iPhone 5c"
        case "iPhone6,1", "iPhone6,2":                   return "iPhone 5s"
        case "iPhone7,2":                                return "iPhone 6"
        case "iPhone7,1":                                return "iPhone 6 Plus"
        case "iPhone8,1":                                return "iPhone 6s"
        case "iPhone8,2":                                return "iPhone 6s Plus"
        case "iPhone9,1", "iPhone9,3":                   return "iPhone 7"
        case "iPhone9,2", "iPhone9,4":                   return "iPhone 7 Plus"
        case "iPhone8,4":                                return "iPhone SE"
        case "iPhone10,1", "iPhone10,4":                 return "iPhone 8"
        case "iPhone10,2", "iPhone10,5":                 return "iPhone 8 Plus"
        case "iPhone10,3", "iPhone10,6":                 return "iPhone X"
            
        case "AppleTV5,3":                               return "Apple TV"
        case "AppleTV6,2":                               return "Apple TV 4K"
        case "AudioAccessory1,1":                        return "HomePod"
        case "i386", "x86_64":                           return "Simulator"
        default:                                         return identifier
        }
    }
    
    var type: DeviceType {
        switch self.modelName {
        case "iPod Touch 1":                    return .iPod1
        case "iPod Touch 2":                    return .iPod2
        case "iPod Touch 3":                    return .iPod3
        case "iPod Touch 4":                    return .iPod4
        case "iPod Touch 5":                    return .iPod5
        case "iPod Touch 6":                    return .iPod5
            
        case "iPad 2":                          return .iPad2
        case "iPad 3":                          return .iPad3
        case "iPad 4":                          return .iPad4
        case "iPad 5":                          return .iPad5
        case "iPad Air 1":                      return .iPadAir1
        case "iPad Air 2":                      return .iPadAir2
        case "iPad Mini 1":                     return .iPadMini1
        case "iPad Mini 2":                     return .iPadMini2
        case "iPad Mini 3":                     return .iPadMini3
        case "iPad Mini 4":                     return .iPadMini4
        case "iPad Pro 9.7 Inch":               return .iPadPro9_7
        case "iPad Pro 12.9 Inch":              return .iPadPro12_9
        case "iPad Pro 12.9 Inch 2.Generation": return .iPadPro12_9
        case "iPad Pro 10.5 Inch":              return .iPadPro10_5
            
        case "iPhone 4":                        return .iPhone4
        case "iPhone 4s":                       return .iPhone4S
        case "iPhone 5":                        return .iPhone5
        case "iPhone 5c":                       return .iPhone5C
        case "iPhone 5s":                       return .iPhone5S
        case "iPhone 6":                        return .iPhone6
        case "iPhone 6 Plus":                   return .iPhone6plus
        case "iPhone 6s":                       return .iPhone6S
        case "iPhone 6s Plus":                  return .iPhone6Splus
        case "iPhone 7":                        return .iPhone7
        case "iPhone 7 Plus":                   return .iPhone7plus
        case "iPhone SE":                       return .iPhoneSE
        case "iPhone 8":                        return .iPhone8
        case "iPhone 8 Plus":                   return .iPhone8plus
        case "iPhone X":                        return .iPhoneX
            
        case "Apple TV":                        return .appleTV
        case "Apple TV 4K":                     return .appleTV4K
        case "HomePod":                         return .homePod
        case "Simulator":                       return .simulator
        default:                                return .unrecognized
        }
    }
    
    
}



