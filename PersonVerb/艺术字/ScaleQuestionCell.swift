//
//  ScaleQuestionCell.swift
//  PersonVerb
//
//  Created by GongHua Guo on 2018/3/8.
//  Copyright © 2018年 GongHua Guo. All rights reserved.
//

import UIKit

class ScaleQuestionCell: UITableViewCell {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var content: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = .clear
        self.textView.isSelectable = false
        self.selectionStyle = .none
        self.textView.layoutManager.allowsNonContiguousLayout = false
        self.content.font = UIFont.systemFont(ofSize: SCREENH == 568 ? 18 : 20)
        self.textView.font = UIFont.systemFont(ofSize: SCREENH == 568 ? 17 : 19)
        self.textView.showsVerticalScrollIndicator = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
  
    @IBAction func selectedButton(_ sender: UIButton) {
        
        let offsizeY : CGFloat = 30
        
        if self.textView.contentOffset.y == self.textView.contentSize.height - self.textView.frame.size.height {
            return
        }
        else if self.textView.contentOffset.y + offsizeY <= self.textView.contentSize.height - self.textView.frame.size.height {
            self.textView.setContentOffset(CGPoint.init(x: 0, y: self.textView.contentOffset.y + offsizeY), animated: true)
        }
        else if self.textView.contentOffset.y + offsizeY > self.textView.contentSize.height - self.textView.frame.size.height {
            self.textView.setContentOffset(CGPoint.init(x: 0, y: self.textView.contentSize.height - self.textView.frame.size.height), animated: true)
        }
        
        
        
    }
    
}
