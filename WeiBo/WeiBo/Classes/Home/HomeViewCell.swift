//
//  HomeViewCell.swift
//  WeiBo
//
//  Created by 渠晓友 on 2017/5/27.
//  Copyright © 2017年 xiaoyouPrince. All rights reserved.
//

import UIKit
import SDWebImage

class HomeViewCell: UITableViewCell {
    
    // MARK: - 控件属性
    var statusVM : StatusViewModel?
    {
        didSet{
            
            if let viewModel = statusVM {
                
//                iconImage.sd_setImage(with: URL(string : (viewModel.status.user?.profile_image_url)!))
                iconImage.sd_setImage(with: statusVM?.profileURL)
                vertifyIcon.image = viewModel.verifiedImage
                vipIcon.image = viewModel.vipImage
                userNameLabel.text = viewModel.status.user?.screen_name
                creatAtLabel.text = viewModel.creatTimeStr
                sourceLabel.text = viewModel.sourceText
                contentLabel.text = viewModel.status.text
                userNameLabel.textColor = vipIcon.image == nil ? UIColor.black : UIColor.orange // 设置用户名文字颜色
            }
        }
    }

    /// 正文宽度约束
    @IBOutlet weak var contentLabelWidthConstraint: NSLayoutConstraint!
    /// 用户头像
    @IBOutlet weak var iconImage: UIImageView!
    /// 认证图标
    @IBOutlet weak var vertifyIcon: UIImageView!
    /// 会员图标
    @IBOutlet weak var vipIcon: UIImageView!
    /// 用户昵称
    @IBOutlet weak var userNameLabel: UILabel!
    /// 创建时间
    @IBOutlet weak var creatAtLabel: UILabel!
    /// 微博来源
    @IBOutlet weak var sourceLabel: UILabel!
    /// 微博正文
    @IBOutlet weak var contentLabel: UILabel!
    
    // MARK: - 系统回调
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentLabelWidthConstraint.constant = kScreenW - 2 * 15
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
