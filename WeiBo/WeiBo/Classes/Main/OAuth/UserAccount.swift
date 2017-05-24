//
//  UserAccount.swift
//  WeiBo
//
//  Created by 渠晓友 on 2017/5/24.
//  Copyright © 2017年 xiaoyouPrince. All rights reserved.
//

import UIKit

class UserAccount: NSObject {
    
    /// 用户授权的唯一票据
    var access_token : String?
    
    ///access_token的生命周期，单位是秒数
    var expires_in : TimeInterval = 0.0{
        didSet{
            
            expires_date = Date(timeIntervalSinceNow: expires_in)
        }
    }
    
    ///授权用户的UID
    var uid : String?
    
    /// 过期日期
    var expires_date : Date?
    
    /// 用户昵称
    var screen_name : String?
    
    /// 用户头像
    var avatar_large : String?
    
    
    
    
    
    override init() {
        super.init()
    }
    
    init(dict : [String : Any]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
    
    override var description: String{
        
        return dictionaryWithValues(forKeys: ["access_token","expires_date","uid","screen_name","avatar_large"]).description
    }

}
