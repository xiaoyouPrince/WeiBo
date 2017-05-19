//
//  ProfileViewController.swift
//  WeiBo
//
//  Created by 渠晓友 on 2017/5/19.
//  Copyright © 2017年 xiaoyouPrince. All rights reserved.
//

import UIKit

class ProfileViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        visitorView.setupVisitorViewInfo(iconName: "visitordiscover_image_profile", tips: "登录后、你的微博、相册、个人资料会展示在这里，展示给别人")
    }
}
