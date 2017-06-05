//
//  Status.swift
//  WeiBo
//
//  Created by 渠晓友 on 2017/5/26.
//  Copyright © 2017年 xiaoyouPrince. All rights reserved.
//

import UIKit

class Status: NSObject {
    
    var created_at : String?                /// 微博创建时间
    var text : String?                      /// 微博正文
    var source : String?                    /// 微博来源
    var id : Int = 0                        /// 微博ID
    var user : User?                        /// 用户类型
    var pic_urls : [[String : String]]?     /// 微博配图
    var retweeted_status : Status?           /// 转发微博
    
    
    
    override init() {
        super.init()
    }
    
    init(dict : [String : AnyObject]){
        super.init()
        
        setValuesForKeys(dict)
        
        // 1. 对微博的用户信息赋值
        if let userDict = dict["user"] as? [String : AnyObject] {
            user = User.init(dict: userDict)
        }
        
        // 2. 对微博的转发微博赋值
        if let retweetStatusDict = dict["retweeted_status"] {
            retweeted_status = Status.init(dict: retweetStatusDict as! [String : AnyObject])
        }

    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {  }

}
