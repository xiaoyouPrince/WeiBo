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
    
    // MARK: - 懒加载图片数组
    fileprivate lazy var composeBtn : UIButton = UIButton(image: "tabbar_compose_icon_add", backgImage: "tabbar_compose_button")

    // MARK: - 系统回调方法
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupComposeBtn()
    }

}


// MARK: - 创建UI
extension MainViewController{
    
    /// 设置发布按钮
    fileprivate func setupComposeBtn() {
        
        // 设置位置
        composeBtn.center = CGPoint(x: tabBar.center.x, y: tabBar.center.y)
        
        // 添加到View上
        self.view.addSubview(composeBtn)
    }
    
}






// MARK: - 使用代码创建项目 - 本项目实际使用SB，所以这段代码只做保留，用于参考
extension MainViewController{
    
    
    fileprivate func buildProjectWithCode() {
        
        // 获取资源地址
        guard let jsonPath = Bundle.main.path(forResource: "MainVCSettings.json", ofType: nil) else { return}
        
        // 读取内容
        guard let data = NSData(contentsOfFile: jsonPath) else { return  }
        
        // json 序列化 -- 由于 Swift 3.0 之后 Data 类型变成了结构体，所以在这块需要和OC相互转化一下
        guard let anyObj = try? JSONSerialization.jsonObject(with: data as Data, options: .mutableContainers) else{return}
        
        // 转化成对应的字典数组
        guard let dictArray = anyObj as? [[String : Any]] else { return}
        
        // 遍历数组中字典，并且赋值
        for dict in dictArray{
            
            let name = dict["vcName"] as! String
            let title = dict["title"] as! String
            let imageName = dict["imageName"] as! String
            
            addChildViewController(childVcName: name , title: title, image: imageName)
            
        }
        
        //        1. 手动添加自控制器
        //        addChildViewController(childVcName: "HomeViewController", title: "首页", image: "tabbar_home")
        //        addChildViewController(childVcName: "MessageViewController", title: "消息", image: "tabbar_message_center")
        //        addChildViewController(childVcName: "DiscoverViewController", title: "发现", image: "tabbar_discover")
        //        addChildViewController(childVcName: "ProfileViewController", title: "我", image: "tabbar_profile")
    }
    
    
    /// 重写一个添加自控制器的方法
    fileprivate func addChildViewController( childVcName: String , title : String , image : String) {
        
        // 1.动态获取命名空间
        guard let nameSpace = Bundle.main.infoDictionary!["CFBundleExecutable"] as? String else {return  }
        
        // 2.获取到对应的childVcClass
        guard let childVcClass = NSClassFromString(nameSpace + "." + childVcName) else {return }
        
        // 3.转化成对应的ViewController类型
        guard let childVCType = childVcClass as? UIViewController.Type else {return }
        
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

