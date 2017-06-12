//
//  HttpTools.swift
//  WeiBo
//
//  Created by 渠晓友 on 2017/6/12.
//  Copyright © 2017年 xiaoyouPrince. All rights reserved.
//

import UIKit
import AFNetworking

class HttpTools: NSObject {
    
    static let manager = AFHTTPSessionManager()
    
    
    /// 发送带图片的微博
    ///
    /// - Parameters:
    ///   - statusText: 微博内容
    ///   - image: image
    ///   - finishCallBack: 回调
    class func sendStatus(statusText : String ,image : UIImage , finishCallBack : @escaping (_ isSuccess : Bool) -> ()) {
        
        let urlStr = "https://upload.api.weibo.com/2/statuses/upload.json"
        let accessToken = UserAccountViewModel.shareInstance.account?.access_token
        let params = ["access_token" : accessToken , "status" : statusText]

        manager.post(urlStr, parameters: params, constructingBodyWith: { (formData) in
            
            let imageData = UIImageJPEGRepresentation(image, 0.5)
            formData.appendPart(withFileData: imageData!, name: "pic", fileName: "123.png", mimeType: "image/png")
            
        }, progress: nil, success: { (_, _) in
            
            finishCallBack(true)
            
        }) { (_, error) in
            
            finishCallBack(false)
            print(error)
        }
    }

}
