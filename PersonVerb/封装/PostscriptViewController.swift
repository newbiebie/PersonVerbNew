//
//  PostscriptViewController.swift
//  PersonVerb
//
//  Created by GongHua Guo on 2018/8/29.
//  Copyright © 2018年 GongHua Guo. All rights reserved.
//

import UIKit

class PostscriptViewController: BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = UIColor.gray
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
        self.tableView?.register(ListViewCell.self, forCellReuseIdentifier: "ListViewCell")
        
        self.getPerSonDataArray()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    // MARK: 自定义方法
    /**获取数据源  以及整理*/
    func getPerSonDataArray(){
        let path = Bundle.main.path(forResource: "ListPlistFile", ofType: "plist")
        let array = NSArray.init(contentsOfFile: path!)
        for item in array! as! [NSDictionary] {
            let model = MoreListModel.init(dic: item as! [AnyHashable : Any])
            self.dataArray!.add(model!)
        }
        
    }
    
    // MARK: UItableview代理方法重写
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListViewCell", for: indexPath) as! ListViewCell
        let model = self.dataArray![indexPath.row] as! MoreListModel
        cell.model = model
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row >= self.dataArray!.count{
            return
        }
        
        let model = self.dataArray![indexPath.row] as! MoreListModel
        
        if model.isRoot == false && model.className != "" {
            self.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(self.creatViewControllerFromStr(classStr: model.className), animated: true)
            self.hidesBottomBarWhenPushed = false
            return;
        }
        

        
        if model.belowCount == 0 {
            
            if model.modelList == nil || model.modelList.count == 0 {
                print("无可展示数据， 请去plist文件中编辑！")
                return;
            }
            
            let array = model.open()
            let indexSet = NSIndexSet.init(indexesIn: NSRange.init(location: indexPath.row + 1, length: array!.count))
            let indexArray = NSMutableArray.init()
            var index = indexPath.row
            
            for _  in array! {
                index = index + 1
                indexArray.add(NSIndexPath.init(row: index, section: indexPath.section))
            }
            self.dataArray!.insert(array!, at: indexSet as IndexSet)
            tableView.insertRows(at: indexArray as! [IndexPath], with: .fade)
        }
        else {
            let array = self.dataArray!.subarray(with: NSRange.init(location: indexPath.row + 1, length: Int(model.belowCount)))
            model.close(withSubmodels: array)
            self.dataArray!.removeObjects(in: array)
            
            let indexArray = NSMutableArray.init()
            var index = indexPath.row
            
            for _  in array {
                index = index + 1
                indexArray.add(NSIndexPath.init(row: index, section: indexPath.section))
            }
            tableView.deleteRows(at: indexArray as! [IndexPath], with: .right)
        }
        self.tableView?.reloadRows(at: NSMutableArray.init(object: indexPath) as! [IndexPath] , with: .fade)
    }
}
