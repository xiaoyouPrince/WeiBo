//
//  OAuthViewController.swift
//  WeiBo
//
//  Created by 渠晓友 on 2017/5/24.
//  Copyright © 2017年 xiaoyouPrince. All rights reserved.
//
//  授权页面OAuth 2.0

import UIKit
import SVProgressHUD

class OAuthViewController: UIViewController {
    
    
    // MARK: - 属性
    @IBOutlet weak var webView: UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        
        loadWebView()
    }

}


// MARK: - 布局UI页面

extension OAuthViewController{
    
    fileprivate func setupNavBar(){
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭", style: .plain, target: self, action: #selector(OAuthViewController.closeBtnClick))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "填充", style: .plain, target: self, action: #selector(OAuthViewController.fillBtnClick))
        title = "登录页面"
    }
    
    
    fileprivate func loadWebView(){

        let Url = URL(string: authUrlStr)!
        
        let request = URLRequest(url: Url)
        
        webView.loadRequest(request)
    }
    
}


// MARK: - 事件监听

extension OAuthViewController{
    
    
    @objc fileprivate func closeBtnClick(){
        
        dismiss(animated: true, completion: nil)
    }
    
    @objc fileprivate func fillBtnClick(){
        
        // 执行JS代码实现
        let jsCode = "document.getElementById('userId').value='15369302863';document.getElementById('passwd').value='xiaoyou';"
        
        webView.stringByEvaluatingJavaScript(from: jsCode)

    }
}


// MARK: - WebView 的代理方法，监听回调地址，取得对应的access_Token

extension OAuthViewController : UIWebViewDelegate{
    
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        let url = request.url!.absoluteString
        
        guard url.contains("code=") else {
            //如果不是回调，可以放行
            return true
        }
        
        //截取对应的code
        let codeRange = url.range(of: "code=")!
        let code = url.substring(from: codeRange.upperBound)
   
        print("------" + url)
        print("------" + code)
        
        
        // 开始请求 access_token
        loadAcceccTokenWithCode(code: code)
        
        
        return false
    }
    
    
    
    
    // MARK: - 设置HUD
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        SVProgressHUD.show()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        SVProgressHUD.dismiss()
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        SVProgressHUD.dismiss()
    }
    
 
}


// MARK: - 请求access_token专用的
extension OAuthViewController{
    
    fileprivate func loadAcceccTokenWithCode(code : String)
    {
        NetworkTools.loadAccessToken(code: code) { (result) in

            print(result!)
            
            // 判断错误的情况
            guard result != nil else{
                return
            }

            let user = UserAccount(dict: result!)
            
            print(user)
        }
    }
    
}
