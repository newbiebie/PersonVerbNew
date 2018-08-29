//
//  RotationViewController.swift
//  PersonVerb
//
//  Created by GongHua Guo on 2018/1/17.
//  Copyright © 2018年 GongHua Guo. All rights reserved.
//

import UIKit

/**cell层的叠压没有经过处理, 仍有一些不必要视觉差*/

class RotationViewController: BaseCanbackViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //给视图添加一个collectionView  懒加载实现
    lazy var collectionView : UICollectionView = {
        let layout  = RotationLayout.init()
        let collectionV : UICollectionView = UICollectionView.init(frame: CGRect.init(x: 0, y: CGFloat(navHieght), width: SCREENW, height: SCREENH * 0.7), collectionViewLayout: layout)
//        if SCREENH == 812 {
//            collectionV.frame = CGRect.init(x: 0, y: 0, width: SCREENW, height: SCREENH - 37)
//        }
        collectionV.center = self.view.center
        collectionV.register(RotationCollectionViewCell.self, forCellWithReuseIdentifier: "RotationCollectionViewCell")
        collectionV.delegate = self
        collectionV.backgroundColor = .gray
        collectionV.dataSource = self
        //不显示侧滑线
        collectionV.showsHorizontalScrollIndicator = false
        
        return collectionV
    }()
    
    
    lazy var titleLabel : UILabel = {
        let label : UILabel = UILabel(frame: CGRect(x: SCREENW / 8, y: navHieght, width: SCREENW * 3 / 4, height: 100))
        label.textAlignment = .center
        label.textColor = .white
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        return label
    }()
    
    var visableItem : Int = 0
    
    var imageArray :  Array<String> = ["number01", "number02", "number03", "number04", "number05", "number06", "number07" ]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .gray
        self.view.addSubview(self.collectionView)
        
        self.titleLabel.text = NSString.init(format: "第1张:\n%@", self.imageArray[0]) as String
        self.view.addSubview(self.titleLabel)
        
        print(SCREENH, SCREENW)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}

/**UIcollectionview相关协议实现*/
extension RotationViewController {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : RotationCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "RotationCollectionViewCell", for: indexPath) as! RotationCollectionViewCell
        cell.imageView?.image = UIImage(named: self.imageArray[indexPath.row])
        cell.label?.text = self.imageArray[indexPath.row]
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imageArray.count
    }
    
    //点击事件响应
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.row != self.visableItem {
            
            //用collectionView的重排功能实现效果
            collectionView.moveItem(at: IndexPath(row: self.visableItem, section: 0), to: indexPath)
            
            //位置调换, 数据源数组也需要更改
            let titleStr = self.imageArray[indexPath.row]
            self.imageArray.remove(at: indexPath.row)
            
            //数据源更新到对应的位置上
            self.imageArray.insert(titleStr, at: self.visableItem)
            
            //标题更换一下
            self.titleLabel.text = NSString.init(format: "第%d张:\n%@",(self.visableItem + 1), self.imageArray[self.visableItem]) as String
            return
        }
        
        OperationQueue.main.addOperation {
            let alertVC = UIAlertController(title: "具体点击的item", message: self.imageArray[indexPath.row], preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "确定", style: .destructive, handler: { (action) in
                
            }))
            self.present(alertVC, animated: true, completion: nil)
        }
    }
}

/**scrollViewDelegate实现*/
extension RotationViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        let layout = self.collectionView.collectionViewLayout as! RotationLayout
        
        //得到对应的item下标   四舍五入计算   直接去掉浮点数, 三的倍数的item会出错误
        let indexFloat = roundf(Float(layout.angle / layout.angleItem))
        
        //类型转化取绝对值
        let itemIndex = abs(Int(indexFloat))
        
        if itemIndex >= self.imageArray.count {
            print(itemIndex)
            return
        }
        
        self.visableItem = itemIndex
        self.titleLabel.text = NSString.init(format: "第%d张:\n%@", itemIndex + 1, self.imageArray[itemIndex]) as String
    }
    
    
}

