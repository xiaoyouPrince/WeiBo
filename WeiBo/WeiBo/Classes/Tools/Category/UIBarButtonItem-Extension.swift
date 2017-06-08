//
//  UIBarButtonItem-Extension.swift
//  WeiBo
//
//  Created by 渠晓友 on 2017/5/20.
//  Copyright © 2017年 xiaoyouPrince. All rights reserved.
//

import UIKit


extension UIBarButtonItem
{
        
    /// 创建一个便利构造函数
    ///
    /// - Parameter imageName: 通过一个image快速生成
    convenience init(imageName : String) {
        
        let btn = UIButton()
        btn.setImage(UIImage(named : imageName ), for: .normal)
        btn.setImage(UIImage(named : imageName + "_highlighted" ), for: .highlighted)
        btn.sizeToFit()
        
        self.init(customView: btn)
        
    }
}
