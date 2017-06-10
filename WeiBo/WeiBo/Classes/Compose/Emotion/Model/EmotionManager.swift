//
//  EmotionManager.swift
//  WeiBo
//
//  Created by 渠晓友 on 2017/6/11.
//  Copyright © 2017年 xiaoyouPrince. All rights reserved.
//

import UIKit

class EmotionManager: NSObject {
    
    // MARK: - 属性
    var packages : [EmotionPackage] = [EmotionPackage]()
    
    // MARK: - 重写init方法
    override init() {
        
        // recent
        packages.append(EmotionPackage(id: ""))
        
        // default
        packages.append(EmotionPackage(id: "com.apple.emoji"))

        // emoji
        packages.append(EmotionPackage(id: "com.sina.default"))
        
        // lxh 
        packages.append(EmotionPackage(id: "com.sina.lxh"))
    
    }
}
