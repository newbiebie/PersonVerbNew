//
//  ViewController.swift
//  PersonVerb
//
//  Created by GongHua Guo on 2018/1/10.
//  Copyright © 2018年 GongHua Guo. All rights reserved.
//

import UIKit
//基类文件  自定义一个基类tableViewController

let bottomHeight : CGFloat = SCREENH == 812 ? 37 : 0

class BaseViewController: BaseController , UITableViewDelegate, UITableViewDataSource {
    
    //数据源数组  在当前类初始化,否则闪退
    var dataArray : NSMutableArray?
    var tableView : UITableView?
    var fontSize : CGFloat = 15.0
    var textColor : UIColor = UIColor.orange
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataArray = NSMutableArray.init()
        //初始化添加
        self.tableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width:SCREENW , height: SCREENH - bottomHeight))
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView?.tableFooterView = UIView.init()
        self.tableView?.separatorStyle = .none
        self.tableView?.showsVerticalScrollIndicator = false
        self.tableView?.showsHorizontalScrollIndicator = false
        self.tableView?.estimatedRowHeight = 100
        self.tableView?.backgroundColor = .clear
        self.view.addSubview(self.tableView!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    /**UItableview相关协议*/
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.dataArray?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell");
        if (cell == nil) {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: "cell")
        }
        cell?.selectionStyle = .none
        cell?.backgroundColor = UIColor.clear
        cell?.accessoryType = .disclosureIndicator
        cell?.textLabel?.attributedText = self.setSpaceForLabelText(title: self.dataArray![indexPath.row] as! String, fontSize: self.fontSize)
        cell?.textLabel?.numberOfLines = 0
        cell?.textLabel?.textColor = self.textColor
        return cell!;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func setSpaceForLabelText(title : String, fontSize : CGFloat) -> NSAttributedString {
        let paraph = NSMutableParagraphStyle.init()
        paraph.lineSpacing = 8
        let attributes = [NSAttributedStringKey.font : UIFont.systemFont(ofSize: fontSize),
                          NSAttributedStringKey.paragraphStyle : paraph]
        return NSAttributedString.init(string: title, attributes: attributes)
    }
}


