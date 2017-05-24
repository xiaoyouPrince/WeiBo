//
//  UserAccount.swift
//  WeiBo
//
//  Created by 渠晓友 on 2017/5/24.
//  Copyright © 2017年 xiaoyouPrince. All rights reserved.
//

import UIKit

class UserAccount: NSObject , NSCoding{
    
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
    
    
    // MARK: - 归档&接档
    /// 解档
    required init?(coder aDecoder: NSCoder) {
        
        access_token = aDecoder.decodeObject(forKey: "access_token") as? String
        uid = aDecoder.decodeObject(forKey: "uid") as? String
        expires_date = aDecoder.decodeObject(forKey: "expires_date") as? Date
        screen_name = aDecoder.decodeObject(forKey: "screen_name") as? String
        avatar_large = aDecoder.decodeObject(forKey: "avatar_large") as? String
        
    }
    /// 归档
    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(access_token, forKey: "access_token")
        aCoder.encode(uid, forKey: "uid")
        aCoder.encode(expires_date, forKey: "expires_date")
        aCoder.encode(screen_name, forKey: "screen_name")
        aCoder.encode(avatar_large, forKey: "avatar_large")
    }

}
