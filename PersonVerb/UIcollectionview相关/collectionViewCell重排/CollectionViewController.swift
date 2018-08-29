//
//  CollectionViewController.swift
//  PersonVerb
//
//  Created by GongHua Guo on 2018/1/15.
//  Copyright © 2018年 GongHua Guo. All rights reserved.
//

import UIKit

class CollectionViewController: BaseController , UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    
    var dataArray : Array<String> = ["路飞", "索隆", "乌索普", "娜美", "罗宾", "山治", "乔巴", "布鲁克", "弗兰奇", "卡卡西", "鸣人", "雏田", "宁次", "洛克 李", "迈特 凯", "鹿丸", "手鞠", "我爱罗", "宇智波 佐助", "宇智波 鼬", "长门", "自来也", "猿飞日斩", "春野樱", "井野", "佐井", "牙", "波风水门", "巴基", "香克斯", "佩罗娜"]
    
    //给视图添加一个collectionView  懒加载实现
    lazy var collectionView : UICollectionView = {
        let layout : UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        
        
        let collectionV : UICollectionView = UICollectionView.init(frame: self.view.bounds, collectionViewLayout: layout)
        if SCREENH == 812 {
            collectionV.frame = CGRect.init(x: 0, y: 0, width: SCREENW, height: SCREENH - 37)
        }
        collectionV.register(AginCollectionViewCell.self, forCellWithReuseIdentifier: "AginCollectionViewCell")
        collectionV.delegate = self
        collectionV.backgroundColor = .white
        collectionV.dataSource = self
        
        //不显示侧滑线
        collectionV.showsVerticalScrollIndicator = false
        
        //为collectionView长按手势
        let longPress : UILongPressGestureRecognizer = UILongPressGestureRecognizer.init(target: self, action: #selector(self.longPressAction(recognizer:)))
        collectionV.addGestureRecognizer(longPress)
        
        return collectionV
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.collectionView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    /**长按手势的处理事件*/
    @objc func longPressAction(recognizer : UIGestureRecognizer){
        
        let indexPath  = self.collectionView.indexPathForItem(at: recognizer.location(in: self.collectionView))
        switch recognizer.state {
        case .began:
            self.collectionView.beginInteractiveMovementForItem(at: indexPath! as IndexPath)
            break
        case .changed:
            self.collectionView.updateInteractiveMovementTargetPosition(recognizer.location(in: self.collectionView))
            break
        case .ended:
            self.collectionView.endInteractiveMovement()
            break
        default:
            print("未选中状态")
        }
        
    }
}

/**回调相关事件处理*/
extension CollectionViewController {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : AginCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "AginCollectionViewCell", for: indexPath) as! AginCollectionViewCell
        cell.label?.text = self.dataArray[indexPath.row]
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: (SCREENW - 50) / 4, height: (SCREENW - 50) / 4)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 10)
    }
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        
        print(sourceIndexPath.row, destinationIndexPath.row)
        let titleStr = self.dataArray[sourceIndexPath.item]
        self.dataArray.remove(at: sourceIndexPath.item)
        self.dataArray.insert(titleStr, at: destinationIndexPath.item)
    }
    
}
