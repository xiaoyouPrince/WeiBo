//
//  Status.swift
//  WeiBo
//
//  Created by 渠晓友 on 2017/5/26.
//  Copyright © 2017年 xiaoyouPrince. All rights reserved.
//

import UIKit

class Status: NSObject {
    
    var created_at : String?         /// 微博创建时间
    {
        didSet{
            
            // Fri May 26 14:54:14 +0800 2017
            creatTimeStr = Date.creatDateString(creatAtString: created_at!)
        }
    }
    var text : String?              /// 微博正文
    var source : String?           /// 微博来源
    {
        didSet{
            
            // 截取用户微博来源
            // "<a href=\"http://app.weibo.com/t/feed/4WrlHq\" rel=\"nofollow\">专业版微博平台</a>"
            guard (source != nil), source != "" else {
                return
            }
            
            let startIndex = ((source as NSString?)?.range(of: ">").location)! + 1
            let length = ((source as NSString?)?.range(of: "</").location)! - startIndex
            
            // 恶心的Swift3.0中的Range
            sourceText = (source! as NSString).substring(with: NSMakeRange(startIndex, length))

        }
    }
    var id : Int = 0               /// 微博ID
    var user : User?               /// 用户类型
    
    var sourceText : String?       /// 微博正文，经过处理后直接使用
    var creatTimeStr : String?     /// 微博正文，经过处理后直接使用

    
    
    
    
    
    override init() {
        super.init()
    }
    
    init(dict : [String : AnyObject]){
        super.init()
        
        setValuesForKeys(dict)
        
        if let userDict = dict["user"] as? [String : AnyObject] {
            user = User.init(dict: userDict)
        }
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {  }

}
