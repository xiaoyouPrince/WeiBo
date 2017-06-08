//
//  ComposeTextView.swift
//  WeiBo
//
//  Created by 渠晓友 on 2017/6/8.
//  Copyright © 2017年 xiaoyouPrince. All rights reserved.
//

import UIKit
import SnapKit

class ComposeTextView: UITextView {
    
    // MARK: - 属性
    lazy var label : UILabel = UILabel()  /// 站位label


    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupPlaceholder("分享新鲜事...")
        self.alwaysBounceVertical = true
        textContainerInset = UIEdgeInsets(top: 8, left: 7, bottom: 0, right: 7)
        
    }
}


extension ComposeTextView
{
    
    /// 给自己设置一个站位文字
    ///
    /// - Parameter placeholder: 站位文字
    fileprivate func setupPlaceholder(_ placeholder : String ){
        
        self.addSubview(label)
        
        label.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(8)
            make.left.equalTo(self).offset(10)
        }
        
        label.text = placeholder
        label.textColor = UIColor.lightGray
        label.font = UIFont.systemFont(ofSize: 14)
        
    }
    
}
