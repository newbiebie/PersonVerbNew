//
//  MasonryListViewController.swift
//  PersonVerb
//
//  Created by GongHua Guo on 2018/3/19.
//  Copyright © 2018年 GongHua Guo. All rights reserved.
//

import UIKit

class MasonryListViewController: BaseViewController {
    
    let padding : CGFloat = 20
    let itemWidth = (SCREENW - 4 * 20) / 3

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView?.tableHeaderView = self.creatTableViewHeader()
        self.dataArray = ["千古兴亡多少事？悠悠。不尽长江滚滚流。", "蒹葭苍苍，白露为霜。所谓伊人，在水一方。溯洄从之，道阻且长。溯游从之，宛在水中央。", "一个人总要走陌生的路，看陌生的风景，听陌生的歌，然后在某个不经意的瞬间，你会发现，原本费尽心机想要忘记的事情真的就这么忘记了。", "如果没有了眼泪，心是一片干涸的湖。", "不是每一次努力都会有收获，但是，每一次收获都必须努力，这是一个不公平的不可逆转的命题。", "若有一种爱是永不能相见，永不能启口，永不能在想起，就好象永不燃起的火种，孤独的凝望着黑暗的天空，但总有一颗心需要讲明，需要倾诉，需要将爱进行到最后一刻，才不枉此生。"]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    /**tableViewHeader  -->  九宫格布局*/
    func creatTableViewHeader() -> UIView{
        let viewB = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREENW, height: SCREENW))
        viewB.backgroundColor = .lightGray
        for index in stride(from: 0, to: 9, by: 1){
            let label = UILabel()
            viewB.addSubview(label)
            label.textAlignment = .center
            label.text = String(index + 1)
            label.backgroundColor = .orange
            label.textColor = .white
            label.font = UIFont.systemFont(ofSize: 17.0)
            label.frame = CGRect.init(x:  CGFloat(index).truncatingRemainder(dividingBy: 3) * (itemWidth + padding) + padding, y: CGFloat(index / 3) * (itemWidth + padding) + padding, width: itemWidth, height: itemWidth)
        }
        return viewB
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifer = "cell"
        var cell = tableView.dequeueReusableCell(withIdentifier: identifer) as? MasonryCell
        if cell == nil {
            cell = MasonryCell.init(style: .default, reuseIdentifier: identifer)
        }
        cell?.contentLabel?.text = self.dataArray![indexPath.row] as? String
        return cell!
    }
    
}
