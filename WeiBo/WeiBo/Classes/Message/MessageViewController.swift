//
//  MessageViewController.swift
//  WeiBo
//
//  Created by 渠晓友 on 2017/5/19.
//  Copyright © 2017年 xiaoyouPrince. All rights reserved.
//

import UIKit

class MessageViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        visitorView.setupVisitorViewInfo(iconName: "visitordiscover_image_message", tips: "登录后、别人评论你的微博，给你发消息，都会在这里收到通知")
    }
}
