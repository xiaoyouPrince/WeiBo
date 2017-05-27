//
//  HomeViewCell.swift
//  WeiBo
//
//  Created by 渠晓友 on 2017/5/27.
//  Copyright © 2017年 xiaoyouPrince. All rights reserved.
//

import UIKit

class HomeViewCell: UITableViewCell {
    
    // MARK: - 控件属性
    @IBOutlet weak var contentLabelWidthConstraint: NSLayoutConstraint!
    
    
    // MARK: - 系统回调
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentLabelWidthConstraint.constant = kScreenW - 2 * 15
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
