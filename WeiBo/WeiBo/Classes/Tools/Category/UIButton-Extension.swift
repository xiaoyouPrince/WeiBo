//
//  UIButton-Extension.swift
//  WeiBo
//
//  Created by 渠晓友 on 2017/5/19.
//  Copyright © 2017年 xiaoyouPrince. All rights reserved.
//

import UIKit


extension UIButton{
    
    
    /// 创建一个类方法
    class func creatButton() -> UIButton {
        
        return UIButton()
    }
    
    
    /// 创建一个便利构造方法
    convenience init(image : String , backgImage: String) {
        self.init() // 必须显式调用自己的 init() 方法
        
        // 设置属性
        setImage(UIImage(named : image), for: .normal)
        setImage(UIImage(named : image + "_highlighted"), for: .highlighted)
        setBackgroundImage(UIImage(named : backgImage), for: .normal)
        setBackgroundImage(UIImage(named : backgImage + "_highlighted"), for: .highlighted)
        
        sizeToFit()
    }
    
    /// 遍历构造行数
    convenience init(bgColor : UIColor , fontSize : CGFloat , title : String) {
        self.init()
        
        backgroundColor = bgColor
        titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        setTitle(title, for: .normal)
    }
    
}
