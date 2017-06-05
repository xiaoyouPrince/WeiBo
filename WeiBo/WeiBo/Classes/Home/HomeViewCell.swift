//
//  HomeViewCell.swift
//  WeiBo
//
//  Created by 渠晓友 on 2017/5/27.
//  Copyright © 2017年 xiaoyouPrince. All rights reserved.
//

import UIKit
import SDWebImage

private let edgeMargin : CGFloat = 15
private let itemMargin : CGFloat = 10

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
                // 计算picView的宽度和高度                
                picViewHcons.constant = self.calculatePicViewSize(count: (statusVM?.picURLs.count ?? 0)! ).height
                picVIewWcons.constant = self.calculatePicViewSize(count: (statusVM?.picURLs.count ?? 0)! ).width
                picView.picUrls = (statusVM?.picURLs)!
            }
        }
    }

    /// 正文宽度约束
    @IBOutlet weak var contentLabelWidthConstraint: NSLayoutConstraint!
    /// picView 的高度约束
    @IBOutlet weak var picViewHcons: NSLayoutConstraint!
    /// picView 的宽度约束
    @IBOutlet weak var picVIewWcons: NSLayoutConstraint!
    
    
    
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
    /// 微博图片内容
    @IBOutlet weak var picView: PicCollectionView!

    
    // MARK: - 系统回调
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 一次性设置内容Label的宽度，来以此准确的自动计算内容Label的高度。
        contentLabelWidthConstraint.constant = kScreenW - 2 * 15
        
        // 设置 picView 的 itemLayout 
        let layout = picView.collectionViewLayout as! UICollectionViewFlowLayout
        let imageViewWH : CGFloat = (kScreenW - 2 * edgeMargin - 2 * itemMargin) / 3
        layout.itemSize = CGSize(width: imageViewWH, height: imageViewWH)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}


extension HomeViewCell{
    
    
    /// 计算picView 的Size
    ///
    /// - Parameter count: 图片数量
    /// - Returns: Size
    fileprivate func calculatePicViewSize(count : Int) -> CGSize {
        
        // 没有配图
        if count == 0 {
            return CGSize.zero
        }
        
        // 计算imageView的WH
        let imageViewWH : CGFloat = (kScreenW - 2 * edgeMargin - 2 * itemMargin) / 3
        
        // 4张配图
        if count == 4 {
            let picViewWH = imageViewWH * 2 + itemMargin
            return CGSize(width: picViewWH, height: picViewWH)
        }
        
        // 其他张数配图
        let rows = CGFloat((count - 1) / 3 + 1 )
        let picViewH = rows * imageViewWH + (rows - 1) * itemMargin
        let picViewW = kScreenW - 2 * edgeMargin
        
        return CGSize(width: picViewW, height: picViewH)
        
    }
}
