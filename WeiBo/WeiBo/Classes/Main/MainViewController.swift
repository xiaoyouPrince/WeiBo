//
//  MainViewController.swift
//  WeiBo
//
//  Created by 渠晓友 on 2017/5/19.
//  Copyright © 2017年 xiaoyouPrince. All rights reserved.
//
//  主控制器

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        addChildViewController(childVcName: "HomeViewController", title: "首页", image: "tabbar_home")
        addChildViewController(childVcName: "MessageViewController", title: "消息", image: "tabbar_message_center")
        addChildViewController(childVcName: "DiscoverViewController", title: "发现", image: "tabbar_discover")
        addChildViewController(childVcName: "ProfileViewController", title: "我", image: "tabbar_profile")

    }
    
    
    // 重写一个添加自控制器的方法
    fileprivate func addChildViewController( childVcName: String , title : String , image : String) {
        
        // 1.动态获取命名空间
        guard let nameSpace = Bundle.main.infoDictionary!["CFBundleExecutable"] as? String else {
            print("没有得到对应的nameSpace")
            return
        }
        
        // 2.获取到对应的childVcClass
        guard let childVcClass = NSClassFromString(nameSpace + "." + childVcName) else {
            print("没有得到对应的childVcClass")
            return
        }
        
        // 3.转化成对应的ViewController类型
        guard let childVCType = childVcClass as? UIViewController.Type else {
            return
        }
        
        
        // 4.设置自控制器的属性
        let childVc = childVCType.init()
        
        childVc.navigationItem.title = title
        childVc.tabBarItem.title = title
        childVc.tabBarItem.image = UIImage(named: image)
        childVc.tabBarItem.selectedImage = UIImage(named: image + "_highlighted")
        
        // 5.包装导航控制器
        let nav = UINavigationController(rootViewController: childVc)
        
        addChildViewController(nav)
    }

}
