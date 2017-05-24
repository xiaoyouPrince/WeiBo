//
//  BaseViewController.swift
//  WeiBo
//
//  Created by 渠晓友 on 2017/5/19.
//  Copyright © 2017年 xiaoyouPrince. All rights reserved.
//

import UIKit

class BaseViewController: UITableViewController {
    
    // MARK: - 懒加载visitorView
    var visitorView : VisitorView = VisitorView.visitorView()
    
    /// 属性： 是否登录
    var isLogin : Bool = false
    
    
    // MARK: - 系统调用
    override func loadView() {
        
        isLogin ? super.loadView() : setupVisitorView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavItems()
    }
}


// MARK: - 创建UI
extension BaseViewController {
    
    /// 创建访客视图
    fileprivate func setupVisitorView(){
        
        // 1.直接当做本身View展示
        view = visitorView
        
        // 2.添加对应的事件监听
        visitorView.registerBtn.addTarget(self, action: #selector(BaseViewController.registerBtnClick), for: .touchUpInside)
        visitorView.loginBtn.addTarget(self, action: #selector(BaseViewController.loginBtnClick), for: .touchUpInside)
        
    }
    
    /// 设置导航左右barbuttonitem
    fileprivate func setupNavItems(){
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: .plain, target: self, action: #selector(BaseViewController.registerBtnClick))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登录", style: .plain, target: self, action: #selector(BaseViewController.loginBtnClick))
        
    }
    
}



// MARK: - 事件监听处理
extension BaseViewController{
    
    @objc fileprivate func registerBtnClick() {
        print("注册按钮点击----")
        
//        UIAlertView(title: "你好", message: "新浪官方未开放此接口", delegate: nil, cancelButtonTitle: "确定").show()

    }
    
    
    @objc fileprivate func loginBtnClick() {
        print("登录按钮点击----")
        
        // 进授权页面
        let oauthVC = OAuthViewController()
        
        let nav = UINavigationController(rootViewController: oauthVC)
        
        present(nav, animated: true, completion: nil)
        
    }
    
}
