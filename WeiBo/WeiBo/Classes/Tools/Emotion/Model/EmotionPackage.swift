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
        super.init()
        
        // 判断是 recent
        if id == "" {
            
            addEmptyEmotion(isRecent: true)
            return
        }
        
        // 读取 表情包数据
        let plistPath = Bundle.main.path(forResource: "\(id)/info.plist", ofType: nil, inDirectory: "Emoticons.bundle")!
        let array = NSArray.init(contentsOfFile: plistPath) as! [[String : String]]
        
        // 添加普通表情
        var index = 0
        for var dict in array {
            
            // 数据处理
            if var png = dict["png"] {
                png = "\(id)" + "/" + png
                dict["png"] = png
            }
            index += 1
            emotions.append(Emotion(dict : dict))
            
            // 添加 删除表情
            if index == 20 {
                emotions.append(Emotion(isRemove: true))
                index = 0
            }
        }
        
        // 添加空表情
        addEmptyEmotion(isRecent: false)
    }
    
    
    /// 添加空表情
    ///
    /// - Parameter isRecent: 是否是最近
    fileprivate func addEmptyEmotion(isRecent : Bool) {
        
        let count = emotions.count % 21
        
        // 防止是 recent == 0 的情况
        if count == 0 && !isRecent{
            return
        }
        
        for _ in count..<20 {
            emotions.append(Emotion(isEmpty : true))
        }
        
        emotions.append(Emotion(isRemove: true))
    }
}
