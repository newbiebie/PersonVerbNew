//
//  CollectionViewVCViewController.swift
//  PersonVerb
//
//  Created by GongHua Guo on 2018/9/10.
//  Copyright © 2018年 GongHua Guo. All rights reserved.
//

import UIKit

class CollectionViewVCViewController: BaseCanbackViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UINavigationControllerDelegate {
    var collectionView : UICollectionView?
    
    let listRow : NSInteger = 2
    let space : CGFloat = 30
    
    var selectedIndex : IndexPath?
    var finalrect : CGRect?
    
    let dataArray : Array<NSDictionary> = [["title" : "像小强一样活着", "image" :"number01" ], ["title" : "大王叫我来巡山", "image" :"number02" ], ["title" : "都选C", "image" :"number03" ], ["title" : "绝世高手", "image" :"number04" ], ["title" : "世界上不存在的歌", "image" :"number05" ], ["title" : "悟空传", "image" :"number06" ]]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "CollectionViewVC视图"
        
        self.setUI()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.delegate = self
    }

    //MARK: 界面UI创建
    func setUI() {
        
        let layout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = space
        layout.minimumLineSpacing = space
        self.collectionView = UICollectionView.init(frame: CGRect.init(x: 0, y: navHieght, width: SCREENW, height: SCREENH - navHieght - bottomHeight), collectionViewLayout: layout)
        self.view.addSubview(self.collectionView!)
        
        self.collectionView?.delegate = self
        self.collectionView?.dataSource = self
        self.collectionView?.backgroundColor = .white
        self.collectionView?.register(UINib.init(nibName: "VCViewCell", bundle: nil), forCellWithReuseIdentifier: "VCViewCell")
    }
    
    //MARK: UICollectionviewC回调方法实现
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VCViewCell", for: indexPath) as! VCViewCell
        let param = self.dataArray[indexPath.row]
        cell.iconImage.image = UIImage.init(named: param.object(forKey: "image") as! String)
        cell.titleLabel.text = param.object(forKey: "title") as? String
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: (SCREENW - CGFloat(self.listRow + 1) * space) / CGFloat(self.listRow), height: (SCREENW - CGFloat(self.listRow + 1) * space) / CGFloat(self.listRow) * 1.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(space, space, 0, space)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let param = self.dataArray[indexPath.row]
        let vc = SecondViewController()
        vc.titleStr = param.object(forKey: "title") as! String
        vc.imageStr = param.object(forKey: "image") as? String
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: 自定义方法
    /**
     视图动画
     */
    func animationNow(itemV : UIView){

        self.view.addSubview(itemV)
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1.0, options: .curveLinear, animations: {
            itemV.frame = self.view.bounds
        }) { (icomPlection) in

        }
    }
    
    //MARK: UINavgationControllerDelegate协议实现  push的时候效果
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        if (toVC.isKind(of:SecondViewController.self) && operation == UINavigationControllerOperation.push) {
            //跳转指定的界面， 指定过度动画
            return NavgationAnimation.init(type: .push)
        }
        else {
            return nil
        }
    }
}
