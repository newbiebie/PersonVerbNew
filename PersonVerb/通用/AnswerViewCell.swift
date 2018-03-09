//
//  AnswerViewCell.swift
//  PersonVerb
//
//  Created by GongHua Guo on 2018/3/7.
//  Copyright © 2018年 GongHua Guo. All rights reserved.
//

import UIKit

class AnswerViewCell: UITableViewCell {
    
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var Img: UIImageView!
    
    @IBOutlet weak var buttonImg: UIButton!
    @IBOutlet weak var contentTop: NSLayoutConstraint!
    @IBOutlet weak var contentLeft: NSLayoutConstraint!
    @IBOutlet weak var contentRight: NSLayoutConstraint!
    @IBOutlet weak var contentBottom: NSLayoutConstraint!
    
    @IBOutlet weak var imgTop: NSLayoutConstraint!
    @IBOutlet weak var imgBottom: NSLayoutConstraint!
    @IBOutlet weak var imgLeft: NSLayoutConstraint!
    @IBOutlet weak var imgRight: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = .clear
        self.selectionStyle = .none
        
        
        if SCREENH == 667 || SCREENH == 568 {
            imgTop.constant = 5
            imgBottom.constant = 5
            contentBottom.constant = 18
            contentTop.constant = 20
        }
        else {
            imgTop.constant = 10
            imgBottom.constant = 10
            contentTop.constant = 25
            contentBottom.constant = 23
        }
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
