//
//  NetworkTools.swift
//  WeiBo
//
//  Created by 渠晓友 on 2017/5/24.
//  Copyright © 2017年 xiaoyouPrince. All rights reserved.
//
//  封装一个网络请求工具（基于alamofire）

import UIKit
import Alamofire

enum RequestMethod  {
    
    case GET
    case POST
}

// 封装一个网络请求工具，这里不继承NSObject了，更加简洁一些
class NetworkTools {
    
    // 自定义一个类方法
    class func requestData(type:RequestMethod , URLString : String , parameters : [String : Any]? = nil , finishCallBack:@escaping (_ response : AnyObject) -> ()){
        
        // 获取类型
        let method = type == .GET ? HTTPMethod.get : HTTPMethod.post
        
        Alamofire.request(URLString, method: method, parameters: parameters).responseJSON { (response) in
            
            // 1.校验返回值
            guard let result = response.result.value else{
                
                print(response.error!)
                return
            }
            
            // 2.回调正确的返回
            finishCallBack(result as AnyObject)
            
        }
    }
    
    
    // get请求
    class func getData(URLString : String , finishCallBack:@escaping (_ response : AnyObject) -> ()) {
        
        // 调用类方法
        requestData(type: .GET, URLString: URLString) { (response) in
            
            finishCallBack(response)
        }
        
    }
    
    
    /// post请求
    // MARK: - post请求
    class func postData(URLString : String , parameters : [String : NSString]? = nil, finishCallBack:@escaping (_ response : AnyObject) -> ()) {
        
        requestData(type:.POST, URLString: URLString, parameters: parameters) { (response) in
            finishCallBack(response)
        }
    }
    
}



// MARK: - 获取AccessToken专用
extension NetworkTools{
    
    class func loadAccessToken(code : String , finishCallBack: @escaping (_ result : [String : Any]? ) -> ()){
        
        let params = ["client_id" : app_key , "client_secret" : app_secret , "grant_type" : "authorization_code", "code" : code ,"redirect_uri" : redirect_uri]
        
        requestData(type: .POST, URLString: "https://api.weibo.com/oauth2/access_token", parameters: params) { (result) in
        
            finishCallBack(result as? [String : Any])
        }
    }
}


// MARK: - 请求用户数据
extension NetworkTools{
    
    class func loadUserInfo(accessToken : String ,uid : String , finishCallBack :@escaping (_ result : Any) -> ()) {
        
        requestData(type: .GET, URLString: "https://api.weibo.com/2/users/show.json", parameters: ["access_token" : accessToken , "uid" : uid]) { (result) in
            
            finishCallBack(result)
        }
    }
}


extension NetworkTools{
    
    class func loadHomeData(finishCallBack:@escaping (_ result : [[String : AnyObject]]? ) -> ()){
        
        // 请求接口
        print(homgDataUrl + "?access_token" + UserAccountViewModel.shareInstance.account!.access_token!)
        
        requestData(type: .GET, URLString: homgDataUrl, parameters: ["access_token" : UserAccountViewModel.shareInstance.account!.access_token!]) { (result) in
            
            // 简单处理，之返回微博数据
            guard result is [String : AnyObject] else{
                return
            }
            
            guard let statusesArray = result["statuses"] as? [[String : AnyObject]] else {
                return
            }
            
            finishCallBack(statusesArray)

            
        }
        
    }
}
