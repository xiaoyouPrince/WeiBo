//
//  UserAccountViewModel.swift
//  WeiBo
//
//  Created by 渠晓友 on 2017/5/25.
//  Copyright © 2017年 xiaoyouPrince. All rights reserved.
//
//  封装一个 UserAccountTool 管理 UserAccount

import UIKit

class UserAccountViewModel: NSObject {
    
    // 封装成单例，方便存取
    static let shareInstance : UserAccountViewModel = UserAccountViewModel()
    
    // MARK: - 定义属性
    var account : UserAccount?
    
    // MARK: - 计算属性
    var accountPath : String {
        
        var path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        path = (path as NSString).strings(byAppendingPaths: ["account.plist"]).first!
        
        print("本沙盒路径 : " + path)
        
        return path
    }
    
    // MARK: - 计算属性，是否过期计算是否登录
    var isLogin : Bool {
        
        // 如果没有读到 account 信息直接 false
        guard let userAccount = account else { return false }
        
//        if let expiresDate = userAccount.expires_date {
//            
//            if expiresDate.compare(Date()) == ComparisonResult.orderedDescending {
//                return true
//            }else{
//                return false
//            }
//            
//        }else {
//            return false
//        }
        
        guard let expiresDate = userAccount.expires_date else {
            return false
        }
        
        if expiresDate.compare(Date()) == ComparisonResult.orderedDescending {
            return true
        }else{
            return false
        }
    }
    
    
    // 重写新建
    override init() {
        super.init()
        
        // 读取 account 信息
        account = NSKeyedUnarchiver.unarchiveObject(withFile: accountPath) as? UserAccount

    }
    
    /// 归档user信息
    func archiveAccount(_ account : UserAccount) {
        
        // 提供一个方法来归档信息
        NSKeyedArchiver.archiveRootObject(account, toFile: accountPath)
    }
    
    

}
