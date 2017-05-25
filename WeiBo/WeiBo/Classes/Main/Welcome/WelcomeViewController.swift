//
//  WelcomeViewController.swift
//  WeiBo
//
//  Created by 渠晓友 on 2017/5/25.
//  Copyright © 2017年 xiaoyouPrince. All rights reserved.
//

import UIKit
//import Kingfisher
import SDWebImage

class WelcomeViewController: UIViewController {
    
    
    // MARK: - 拖线属性
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var iconBottomConstraint: NSLayoutConstraint!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1.给头像添加图片
//        iconView.kf.setImage(with : UserAccountViewModel.shareInstance.account?.avatar_large as? Resource , placeholder: UIImage(named : "avatar_default"), options: nil, progressBlock: nil, completionHandler: nil)
        
        // 弃用KingFisher ，使用SDWebImage
        iconView.sd_setImage(with: URL(string: (UserAccountViewModel.shareInstance.account?.avatar_large)!), placeholderImage: UIImage(named : "avatar_default"))

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 改变约束值、
        self.iconBottomConstraint.constant = UIScreen.main.bounds.size.height - 250
        
        // 添加头像上移动画
        UIView.animate(withDuration: 1.5, delay: 0.0, usingSpringWithDamping: 0.7 , initialSpringVelocity: 4.0 , options: [], animations: {
            
            self.view.layoutIfNeeded()
            
        }) { (_) in
            // 完成动画可以做一些操作...
            
            UIApplication.shared.keyWindow?.rootViewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateInitialViewController()
        }
    }

}
