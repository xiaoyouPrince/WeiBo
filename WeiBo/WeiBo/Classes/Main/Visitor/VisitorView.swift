//
//  VisitorView.swift
//  WeiBo
//
//  Created by 渠晓友 on 2017/5/19.
//  Copyright © 2017年 xiaoyouPrince. All rights reserved.
//

import UIKit

class VisitorView: UIView {

    
    // 创建一个对外的公开快速创建的方法
    class func visitorView() -> VisitorView {
        
        return Bundle.main.loadNibNamed("VisitorView", owner: nil, options: nil)?.first as! VisitorView
        
    }
    
    
    // MARK: - 内部属性
    @IBOutlet weak var rotationView: UIImageView!
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var tipsLabel: UILabel!
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    
    
    /// 设置内部visitorView的信息
    func setupVisitorViewInfo(iconName : String , tips : String) {
        
        rotationView.isHidden = true
        iconView.image = UIImage(named: iconName)
        tipsLabel.text = tips
    }
    
    /// 设置rotationView旋转起来
    func addRotationAnim() {
        
        // 创建动画
        let rotationAnim = CABasicAnimation(keyPath: "transform.rotation.z")

        // 设置动画基本属性
        rotationAnim.fromValue = 0
        rotationAnim.toValue = Double.pi * 2
        rotationAnim.repeatCount = MAXFLOAT
        rotationAnim.duration = 5
        
        // 设置当完成不消失，退后台和其他页面无影响
        rotationAnim.isRemovedOnCompletion = false
        
        // 将动画添加到对应的layer层上面
        rotationView.layer.add(rotationAnim, forKey: nil)
        
        
    }
    

}
