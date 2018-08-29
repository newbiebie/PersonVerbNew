//
//  NewPerfectViewController.swift
//  SwiftExercise
//
//  Created by xunji on 2018/8/1.
//  Copyright © 2018年 xunji. All rights reserved.
//

import UIKit



class NewPerfectViewController: BaseCanbackViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let itemHeight = SCREENW * 0.5
    let itemSpace : CGFloat = 20
    var imageView : UIImageView?
    var collectionView : UICollectionView?
    var snapView : UIView?
    var rect : CGRect?
    
    let dataArray : Array<String> = ["number01", "number02", "number03", "number04", "number05", "number06", "number07" ]
    var button : UIButton?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "滚动效果"
        self.addNewCollectionView()
        self.scrollToItem(index: 3)
    }
    
    //添加collectionView
    func addNewCollectionView(){
        
        self.imageView = UIImageView.init()
        self.view.addSubview(self.imageView!)
        
        let layout = PerfectLayout.init()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsetsMake(0, 20, 0, 20)
        
        self.collectionView = UICollectionView.init(frame: CGRect.init(x: 0, y:  SCREENH - bottomHeight - self.itemHeight, width: SCREENW, height: self.itemHeight), collectionViewLayout: layout)
        self.collectionView?.backgroundColor = .clear
        self.collectionView?.delegate = self
        self.collectionView?.dataSource = self
        self.collectionView?.showsHorizontalScrollIndicator = false
        self.collectionView?.isPagingEnabled = false
        self.collectionView?.register(UINib.init(nibName: "PerfectCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PerfectCollectionViewCell")
        self.view.addSubview(self.collectionView!)
        
        self.imageView?.layer.cornerRadius = 10
        self.imageView?.layer.masksToBounds = true
        self.imageView!.mas_makeConstraints({ (maker) in
            maker?.top.equalTo()(self.view)?.offset()(navHieght + 20)
            maker?.left.equalTo()(self.view)?.offset()(20)
            maker?.right.equalTo()(self.view)?.offset()(-20)
            maker?.bottom.equalTo()(self.collectionView!.mas_top)?.offset()(-20)
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PerfectCollectionViewCell", for: indexPath) as! PerfectCollectionViewCell
        let itemStr = self.dataArray[indexPath.row]
        cell.imageB.image = UIImage.init(named: itemStr)
        cell.titleL.text = itemStr
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: SCREENW - self.itemSpace * 2, height: self.itemHeight)
    }
    
    //点击的项目
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! PerfectCollectionViewCell
        
        //获取在视图中位置信息
        self.snapView = cell.imageB.snapshotView(afterScreenUpdates: false)
        
        let rect = self.view.convert(cell.imageB.frame, from: cell.imageB.superview)
        self.rect = rect
        self.snapView!.frame = self.rect!
        self.animationImageView(image: self.snapView!)
    }
    
    //动画的添加
    func animationImageView(image : UIView){
        self.view.addSubview(image)
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1.0, options: .curveLinear, animations: {
            image.frame = self.view.bounds
        }) { (isCompletion) in
            self.buttonAdd()
        }
    }
    
    
    //添加点击按钮事件
    func buttonAdd(){
        self.button = UIButton()
        self.view.addSubview(self.button!)
        self.button?.setTitle("立即体验", for: .normal)
        self.button?.backgroundColor = .orange
        self.button?.setTitleColor(.white, for: .normal)
        self.button?.titleLabel?.font = UIFont.systemFont(ofSize: 18.0)
        self.button?.layer.cornerRadius = 5
        self.button!.mas_makeConstraints({ (maker) in
            maker?.centerX.equalTo()(self.view)
            maker?.bottom.equalTo()(self.view)?.offset()(-(SCREENW * 0.1 + bottomHeight))
            maker?.size.sizeOffset()(CGSize.init(width: SCREENW * 0.5 , height: 40))
        })
        self.button?.addTarget(self, action: #selector(self.buttonActionNow), for: .touchUpInside)
    }
    
    //按钮事件
    @objc func buttonActionNow(){
        self.button?.removeFromSuperview()
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1.0, options: .curveLinear, animations: {
            self.snapView!.frame = self.rect!
        }) { (isCompletion) in
            self.snapView?.removeFromSuperview()
        }
    }
  
    //转到指定位置
    func scrollToItem( index :  NSInteger){
        let newIndex = index < self.dataArray.count ? index : 0
        self.imageView?.image = UIImage.init(named: self.dataArray[newIndex])
        self.collectionView?.scrollToItem(at: NSIndexPath.init(row: newIndex, section: 0) as IndexPath, at: .centeredHorizontally, animated: true)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let offSetX = scrollView.contentOffset.x
        let indexPath = self.collectionView!.indexPathForItem(at: CGPoint.init(x: offSetX + 20, y: 0))
        
        
        if (indexPath != nil) && indexPath!.row < self.dataArray.count {
            self.animationForView(item: self.imageView!)
            self.imageView?.image = UIImage.init(named: self.dataArray[indexPath!.row])
        }
    }
    
    //添加一个动画效果
    func animationForView(item : UIView){
        item.layer.removeAllAnimations()
        let animation = CATransition.init()
        animation.duration = 1.0
        animation.type = "rippleEffect"
        animation.fillMode = kCAFillModeForwards
        item.layer.add(animation, forKey: "animation")
    }
    
}
