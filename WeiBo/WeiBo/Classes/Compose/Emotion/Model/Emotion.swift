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
    var pngPath : String?   ///表情图片的路径
    var emojiCode : String?     ///code处理成 emojiCode码
    var isRemove : Bool = false     ///记录是否是删除表情
    var isEmpty : Bool = false     ///记录是否是空表情
    
    init(dict : [String : Any]){
        super.init()
        setValuesForKeys(dict)
        
    }
    
    init(isRemove : Bool){
        super.init()
        
        // 记录一下这个Emotion是删除表情
        self.isRemove = isRemove
    }
    
    init(isEmpty : Bool){
        super.init()
        
        // 记录一下这个Emotion是空表情
        self.isEmpty = isEmpty
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {    }
    
    
    override var description: String{
        return dictionaryWithValues(forKeys: ["emojiCode","pngPath","chs"]).description
    }

}
