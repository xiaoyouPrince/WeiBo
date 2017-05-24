//
//  Commen.swift
//  WeiBo
//
//  Created by 渠晓友 on 2017/5/24.
//  Copyright © 2017年 xiaoyouPrince. All rights reserved.
//
// 一些授权常量

/// 授权根路径
private let rootUrl = "https://api.weibo.com/oauth2/authorize"

/// client_id 对应参数 app_key
let app_key = "2625427871"

/// app_secret
let app_secret = "eca1ed907d76ad6f6ce62a8feda67a1c"

/// 回调路径
let redirect_uri = "http://www.520it.com"


/// authUrlstring
let authUrlStr = "\(rootUrl)?client_id=\(app_key)&redirect_uri=\(redirect_uri)"


/// 个人用户获取到的code -- xiaoyouPrince
//private let code = "4c963f384d0c98757d47c16e6d51e721"







