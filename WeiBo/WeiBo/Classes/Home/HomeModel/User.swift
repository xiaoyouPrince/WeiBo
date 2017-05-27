//
//  User.swift
//  WeiBo
//
//  Created by 渠晓友 on 2017/5/27.
//  Copyright © 2017年 xiaoyouPrince. All rights reserved.
//
//  用户数据Model

import UIKit

class User: NSObject {
    
    
    // MARK: - 基本属性
    var profile_image_url : String?   // 用户头像
    var screen_name : String?         // 用户昵称
    var mbrank : Int = 0              // 会员等级0-6 共7级
    {
        didSet{
            
            if mbrank > 0 && mbrank < 7 {
                
                vipImage = UIImage(named: "common_icon_membership_level\(mbrank)")
            }
            
        }
    }
    var verified : Bool = false
    var verified_type : Int = -1      // 是否认证和认证类型
    {
        didSet{
            
            switch verified_type {
            case 0:
                verifiedImage = UIImage(named: "avatar_vip") //个人认证
            case 2,3,5:
                verifiedImage = UIImage(named: "avatar_enterprise_vip") //组织企业认证
            case 220:
                verifiedImage = UIImage(named: "avatar_grassroot") //机构认证
            default:
                verifiedImage = nil
            }
        }
    }
    
    // MARK: - 方便使用的属性
    var verifiedImage : UIImage?
    var vipImage : UIImage?
    
    
    
    
    
    init(dict : [String : AnyObject]){
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {

    }
    
}
