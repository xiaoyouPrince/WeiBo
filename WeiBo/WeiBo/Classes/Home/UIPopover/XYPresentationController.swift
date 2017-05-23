//
//  XYPresentationController.swift
//  WeiBo
//
//  Created by 渠晓友 on 2017/5/20.
//  Copyright © 2017年 xiaoyouPrince. All rights reserved.
//

import UIKit

class XYPresentationController: UIPresentationController {
    
    // MARK: - 属性
    /// 外部决定弹出frame  default is zero
    var presentFrame : CGRect = CGRect.zero
    
    fileprivate lazy var coverView : UIView = {
    
        let coverView = UIView()
        
        // coverView的基本属性
        coverView.backgroundColor = UIColor(white: 0.5, alpha: 0.2)
        
        // 添加点击手势
        let tap = UITapGestureRecognizer(target: self, action: #selector(XYPresentationController.dismissPopoverView))
        coverView.addGestureRecognizer(tap)
        
        return coverView
    }()
    
    
    // 重写内部进行布局的类
    override func containerViewWillLayoutSubviews() {
        
        super.containerViewWillLayoutSubviews()
        
        // 1. 修改对应的要展示的frame
        presentedView?.frame = presentFrame
        
        // 2. 添加蒙版
        containerView?.insertSubview(coverView, at: 0)
        coverView.frame = containerView!.bounds
  
    }

}


// MARK: -  事件处理

extension XYPresentationController{
    
    @objc fileprivate func dismissPopoverView()  {
        
        print("--dismissPopoverView--")
        
        presentedViewController.dismiss(animated: true, completion: nil)
        
    }
}
