//
//  TouchViewController.swift
//  PersonVerb
//
//  Created by GongHua Guo on 2018/10/17.
//  Copyright © 2018年 GongHua Guo. All rights reserved.
//

import UIKit

class TouchViewController: BaseViewController, UIViewControllerPreviewingDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "3D Touch效果"
        self.creatBackButton()
        
        self.dataArray = ["number01", "number02", "number03", "number04", "number05", "number06", "number07" ]
        self.tableView?.register(TouchCell.self, forCellReuseIdentifier: "TouchCell")
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TouchCell") as! TouchCell
        cell.imageVC?.image = UIImage.init(named: self.dataArray![indexPath.row] as! String)
        cell.contentLabel?.text = self.dataArray![indexPath.row] as? String
        
        if traitCollection.forceTouchCapability == .available {
            registerForPreviewing(with: self, sourceView: cell)
        }
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK   UIViewControllerPreviewingDelegate协议方法实现
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        let vc = PushTouchViewController.init()
        
        //获取cell所在行，按压所在视图
        let indexPath = self.tableView?.indexPath(for: previewingContext.sourceView as! UITableViewCell)
        
        vc.preferredContentSize = CGSize.init(width: SCREENW , height: SCREENW + navHieght + 40)
        
        //设置预览界面
        vc.imageStr = self.dataArray![indexPath!.row] as? String
        vc.name = self.dataArray![indexPath!.row] as? String
        //设置不被虚化的范围， 按压的cell不被虚化 （轻轻按压周边虚化， 再稍用力弹出预览视图， 再用力跳转指定界面）
        
        let rect = CGRect.init(x: 0, y: 0, width: SCREENW, height: 80)
        previewingContext.sourceRect = rect
        
        return vc
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(viewControllerToCommit, animated: true)
        self.hidesBottomBarWhenPushed = false
    }
    
    
    
}
