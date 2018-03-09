//
//  MYNavgViewController.swift
//  PersonVerb
//
//  Created by GongHua Guo on 2018/1/26.
//  Copyright © 2018年 GongHua Guo. All rights reserved.
//

import UIKit

/**
 图片做导航背景视图，控件移动至导航栏上
 */
class MYNavgViewController: BaseViewController {
    
    //头像最小值缩放比例
    let scale : CGFloat = 0.6
    
    //距右的尺寸
    let rightSpace : CGFloat = 20
    
    let centerY : CGFloat = SCREENH == 812 ? 60 : 40
    
    //iconButton的起始中心点
    let beginX = SCREENW / 2;
    let beginY : CGFloat = 158
    
    lazy var imageView : UIImageView = {
        let imgV = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: Int(SCREENW), height: 200))
        imgV.image = UIImage.init(named: "u=1217168845,239798306&fm=214&gp=0")
        
        //打开交互， 否侧按钮事件不会响应
        imgV.isUserInteractionEnabled = true
        //添加一个返回按钮
        imgV.addSubview(self.button)
        imgV.addSubview(self.iconButon)
        return imgV
    }()
    
    lazy var button : UIButton = {
        let button = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 45, height: 45))
        button.center = CGPoint(x: 30, y: centerY)
        button.addTarget(self, action: #selector(self.backAction(button:)), for: .touchUpInside)
        button.setImage(UIImage.init(named: "返回-3"), for: .normal)
        return button
    }()
    
    
    lazy var iconButon : UIImageView = {
       
        let imageV = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: 64, height: 64))
        imageV.image = UIImage.init(named: "彩灯")
        imageV.center = CGPoint.init(x: beginX, y: beginY)
        return imageV
    }()
    
    
    
    //计算起始坐标和最终坐标间中心点的  X 、 Y距离
    lazy var middleX : CGFloat = {
        //中轴开始起算  减去右间距  减去一半
        let midX = SCREENW / 2 - self.rightSpace - 64 * scale / 2
        return midX
    }()
    
    lazy var middleY : CGFloat = {
        //最初中心点  减去 最终中心点
        let midY = self.beginY - self.centerY
        return midY
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView?.frame = CGRect.init(x: 0, y: 200, width: SCREENW, height: SCREENH - 200)
        self.view.addSubview(self.imageView)
        
        
        self.dataArray = ["心里有光，何惧风浪", "举目无亲的城市，格格不入的言行。某个似曾相识的熟悉场景，是否让人想起了当初那个孤独的自己。初入社会的我们，满脸稚气，会懵懂，会犯错，会迷茫。诺大的城市，行色匆匆的人们，留给自己的，只有决绝的背影，和静默的黑夜。", "开始学着一个人坚强，开始学着慢慢长大，开始学着不动声色的，做一个大人。有伤痛，有苦楚，也有无尽的委屈和心酸。好像人总是这样：一面练习失去，一面不断成长。", "多少次的跌跌撞撞，披荆斩棘，适应改变，换来如今的不慌不忙，淡定自若。我不知道到最后，大多数的人们，究竟有没有成为当时信誓旦旦，口口声声说的那个最想成为的人。但我希望，有人会永远记得，那个稚气的少年，那双清澈的眼睛，那种奋力的奔跑，以及那份单纯的美好。", "也许这个世界没有想象中的那么美丽：不乏丑恶，不公，黑暗。但无论何时，都别忘了心底的坚守和希望。任外面嘈杂喧嚣，别丢掉一直信奉的善良，别放弃曾经拥有的美好。", "这个世界，总会有阳光洒下来的地方。带着善良，带着美好，带着希望。只要心里有光，又何惧沿途的风浪？", "不是拒绝成长，也不是赖着不愿长大，只是不想随着年岁的增加，逐渐变得麻木苍老，过早地体会那种再也找不到什么东西，可以泛起心中涟漪的悲哀。", "一个人再坏都会变好的。你善待别人，别人也会善待你。所以，如果可以，请好好珍惜，并且用力拥抱，这世间所有的美好和善良。愿你我，永远都是当年那个朴素的少年。"]
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    /**返回按钮点击事件*/
    @objc func backAction(button: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.isKind(of: UITableView.self) {
            
            //保留导航栏
            if scrollView.contentOffset.y >= 200 - CGFloat(navHieght) {
                
                self.imageView.frame.size = CGSize.init(width: SCREENW, height: CGFloat(navHieght))
                self.tableView?.frame = CGRect.init(x: 0, y: self.imageView.frame.size.height, width: SCREENW, height: SCREENH - self.imageView.frame.size.height)
                
                //头像   原始尺寸乘以最小缩放比例
                self.iconButon.frame.size = CGSize.init(width: 64 * scale, height: 64 * scale)
                self.iconButon.center = CGPoint.init(x: SCREENW - rightSpace - 64 * scale / 2, y: centerY)
                
            }
            
            //下拉的时候
            else if scrollView.contentOffset.y <= 0 {

                //下拉的距离
                let pollSpace = abs(scrollView.contentOffset.y)
                self.imageView.frame.size = CGSize.init(width: SCREENW, height: 200 + pollSpace)
                self.tableView?.frame = CGRect.init(x: 0, y: 200, width: SCREENW, height: SCREENH - 200)
                
                /**
                 垂直运动:
                 10 : 控件和父视图底部之间的距离
                 32 : 控件本身高的一半
                 
                 缩放比例：以父视图本身高度作参考
                 */
                let frameScale = pollSpace / 200;
                self.iconButon.frame.size = CGSize.init(width: 64 * (1 + frameScale), height: 64 * (1 + frameScale))
                self.iconButon.center = CGPoint.init(x: self.beginX, y: 200 + pollSpace - 10 - 64 * (1 + frameScale) / 2)
            }
            
            //上滑
            else {

                self.imageView.frame.size = CGSize.init(width: SCREENW, height: 200 - scrollView.contentOffset.y)
                self.tableView?.frame = CGRect.init(x: 0, y: self.imageView.frame.size.height, width: SCREENW, height: SCREENH - self.imageView.frame.size.height)
                
                
                //动态变化的时候  位置中心、frame
                //计算缩放比例
                let spaceScale = scrollView.contentOffset.y / (200 - CGFloat(navHieght))
                
                
                /**
                 尺寸缩放比例 = scale为最小基数
                 （1 - scale）:就是可以进行缩放的占比
                 (1 - spaceScale):  取反， 缩放比例为1时， 表示最终坐标
                 (1 - spaceScale) * (1 - self.scale) + self.scale : 最终尺寸进行缩放的比例
                 */
                let frameScale = (1 - spaceScale) * (1 - self.scale) + self.scale
                
                /**
                 Y轴 = 初始 - 缩放距离
                 X轴 = 初始 + 缩放距离
                 */
                self.iconButon.center = CGPoint.init(x: self.beginX + self.middleX * spaceScale, y: self.beginY - self.middleY * spaceScale)
                self.iconButon.frame.size = CGSize.init(width: 64 * frameScale, height: 64 * frameScale)
            }
            
        }
    }
}
