//
//  OAuthViewController.swift
//  WeiBo
//
//  Created by 渠晓友 on 2017/5/24.
//  Copyright © 2017年 xiaoyouPrince. All rights reserved.
//
//  授权页面OAuth 2.0

import UIKit


private let rootUrl = "https://api.weibo.com/oauth2/authorize"
private let client_id = "2625427871"
private let redirect_url = "http://www.520it.com"

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

        let Url = URL(string: "\(rootUrl)")!
        
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
        
    }
}
