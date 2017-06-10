//
//  EmotionPackage.swift
//  WeiBo
//
//  Created by 渠晓友 on 2017/6/11.
//  Copyright © 2017年 xiaoyouPrince. All rights reserved.
//

import UIKit

class EmotionPackage: NSObject {
    
    // MARK: - 属性
    var emotions : [Emotion] = [Emotion]()
    
    
    // 根据 path 添加对应的package
    init(id : String){
        
        if id == "" {
            return
        }
        
        let plistPath = Bundle.main.path(forResource: "\(id)/info.plist", ofType: nil, inDirectory: "Emoticons.bundle")!
        let array = NSArray.init(contentsOfFile: plistPath) as! [[String : String]]
        
        for dict in array {
            
            let emotion = Emotion(dict : dict)
            
            emotions.append(emotion)
        }
        
    }
}
