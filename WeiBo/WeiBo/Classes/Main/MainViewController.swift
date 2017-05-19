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
        
        
        addChildViewController(HomeViewController(), title: "首页", image: "tabbar_home")
        addChildViewController(MessageViewController(), title: "消息", image: "tabbar_message_center")
        addChildViewController(DiscoverViewController(), title: "发现", image: "tabbar_discover")
        addChildViewController(ProfileViewController(), title: "我", image: "tabbar_profile")

    }
    
    
    // 重写一个添加自控制器的方法
    fileprivate func addChildViewController(_ childVc: UIViewController , title : String , image : String) {
        
        // 1.设置自控制器的属性
        childVc.navigationItem.title = title
        childVc.tabBarItem.title = title
        childVc.tabBarItem.image = UIImage(named: image)
        childVc.tabBarItem.selectedImage = UIImage(named: image + "_highlighted")
        
        // 2.包装导航控制器
        let nav = UINavigationController(rootViewController: childVc)
        
        addChildViewController(nav)
    }

}
