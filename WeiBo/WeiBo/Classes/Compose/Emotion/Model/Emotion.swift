//
//  Emotion.swift
//  WeiBo
//
//  Created by 渠晓友 on 2017/6/11.
//  Copyright © 2017年 xiaoyouPrince. All rights reserved.
//

import UIKit

class Emotion: NSObject {
    
    // MARK: - 属性
    var code : String? /// emoji 对应的code
    {
        didSet{
            // 处理emojiCode
            
            guard let code = code else {
                return
            }
            
            let scanner = Scanner(string: code)
            
            var value : UInt32 = 0
            scanner.scanHexInt32(&value)
            
            let scalar = UnicodeScalar(value)
            let c = Character(scalar!)
            
            emojiCode = String(c)
        }
    }
    var png : String?  /// 普通表情对应的png
    {
        didSet{
            
            guard let png = png else {
                return
            }
            
            pngPath = Bundle.main.bundlePath + "/Emoticons.bundle/" + png
        }
    }
    var chs : String?  /// 普通表情对应的文字
    
    // MARK: - 数据处理
    var pngPath : String?
    var emojiCode : String?
    
    init(dict : [String : Any]){
        super.init()
        setValuesForKeys(dict)
        
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {    }
    
    
    override var description: String{
        return dictionaryWithValues(forKeys: ["emojiCode","pngPath","chs"]).description
    }

}
