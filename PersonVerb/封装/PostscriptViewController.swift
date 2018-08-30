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
        
        if array != nil {
            self.dataArray?.addObjects(from: ListModel.mj_objectArray(withKeyValuesArray: array!) as! [Any])
        }
        
    }
    
    // MARK: UItableview代理方法重写
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListViewCell", for: indexPath) as! ListViewCell
        let model = self.dataArray![indexPath.row] as! ListModel
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
        
        let model = self.dataArray![indexPath.row] as! ListModel
        if model.modelList.count <= 0 {
            return;
        }
        
        //open状态  删除对一个的数据
        if model.isOpen {
            let deleteArray = NSMutableArray.init()
            let indexArray = NSMutableArray.init()
            var index : NSInteger = 0
            for item in self.dataArray!{
                let newModel = item as! ListModel
                if newModel.listType == model.listType && newModel.rowNumber > model.rowNumber{
                    deleteArray.add(newModel)
                    indexArray.add(NSIndexPath.init(row: index, section: indexPath.section) as IndexPath)
                }
                
                index = index + 1
            }
            self.dataArray!.removeObjects(in: deleteArray as! [Any])
            self.tableView?.deleteRows(at: indexArray as! [IndexPath], with: .right)
        }
            
            //close状态  添加
        else {
            self.dataArray!.insert(ListModel.mj_objectArray(withKeyValuesArray: model.modelList) as! [Any], at: NSIndexSet.init(indexesIn:NSRange.init(location: indexPath.row + 1, length: model.modelList.count)) as IndexSet)
            var index : NSInteger = indexPath.row
            let indexarray = NSMutableArray.init()
            for _ in model.modelList{
                index = index + 1
                indexarray.add(NSIndexPath.init(row: index, section: indexPath.section) as IndexPath)
            }
            self.tableView?.insertRows(at: indexarray as! [IndexPath], with: .fade)
        }
        model.isOpen = !model.isOpen
        self.tableView?.reloadRows(at: NSMutableArray.init(object: indexPath) as! [IndexPath] , with: .fade)
    }
}
