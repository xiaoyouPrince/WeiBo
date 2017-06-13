//
//  TitleButton.swift
//  WeiBo
//
//  Created by 渠晓友 on 2017/5/20.
//  Copyright © 2017年 xiaoyouPrince. All rights reserved.
//

import UIKit

class TitleButton: UIButton {

    override init(frame: CGRect) {
        // 重写这个方法必须调用父类实现，才会有对应的KVC等方法
        super.init(frame: frame)
        
        // 设置对应属性
        setImage(UIImage(named: "navigationbar_arrow_down"), for: .normal)
        setImage(UIImage(named: "navigationbar_arrow_up"), for: .selected)
        setTitleColor(UIColor.black, for: .normal)
        sizeToFit()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 重新布局
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel!.frame.origin.x = 0
        imageView!.frame.origin.x = (titleLabel?.frame.size.width)! + 5
    }
    
}

