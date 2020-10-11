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
//                contentLabel.text = viewModel.status.text
                let statusText = viewModel.status.text
                contentLabel.attributedText = FindEmotion.shareIntance.findAttrString(statusText: statusText, font: UIFont.systemFont(ofSize: 14))
                userNameLabel.textColor = vipIcon.image == nil ? UIColor.black : UIColor.orange // 设置用户名文字颜色
                // 计算picView的宽度和高度                
                picViewHcons.constant = self.calculatePicViewSize(count: (statusVM?.picURLs.count ?? 0)! ).height
                picVIewWcons.constant = self.calculatePicViewSize(count: (statusVM?.picURLs.count ?? 0)! ).width
                picView.picUrls = (statusVM?.picURLs)!
                // 设置转发微博的内容
                if let retweetText = statusVM?.status.retweeted_status?.text , let screenName = statusVM?.status.retweeted_status?.user?.screen_name{

                    retweetContentLabel.text = "@" + "\(screenName):" + retweetText
                    
                    // 设置装发微博背景
                    retweetStatusBGView.isHidden = false
                    
                    // 设置转发正文的约束
                    retweetContentBottomCons.constant = 10
                    
                }else{
                    retweetContentLabel.text = nil
                    retweetStatusBGView.isHidden = true
                    
                    // 设置转发正文的约束
                    retweetContentBottomCons.constant = 0
                }
                
                // 手动计算cell高度
                if viewModel.cellHeight == 0 {
                    
                    // 1.强制布局
                    self.layoutIfNeeded()
                    
                    // 2.计算并保存cell高度
                    viewModel.cellHeight = self.bottomToolBar.frame.maxY
                }
                
                // MARK: - RELabel监听点击
                
                // 监听用户的点击
                contentLabel.userTapHandler = { (label, user, range) in
                    print(label)
                    print(user)
                    print(range)
                }
                
                // 监听链接的点击
                contentLabel.linkTapHandler = { (label, link, range) in
                    print(label)
                    print(link)
                    print(range)
                }
                
                // 监听话题的点击
                contentLabel.topicTapHandler = { (label, topic, range) in
                    print(label)
                    print(topic)
                    print(range)
                }
                
                // 监听用户的点击
                retweetContentLabel.userTapHandler = { (label, user, range) in
                    print(label)
                    print(user)
                    print(range)
                }
                
                // 监听链接的点击
                retweetContentLabel.linkTapHandler = { (label, link, range) in
                    print(label)
                    print(link)
                    print(range)
                }
                
                // 监听话题的点击
                retweetContentLabel.topicTapHandler = { (label, topic, range) in
                    print(label)
                    print(topic)
                    print(range)
                }

                
            }
        }
    }

    /// 正文宽度约束
    @IBOutlet weak var contentLabelWidthConstraint: NSLayoutConstraint!
    /// picView 的高度约束
    @IBOutlet weak var picViewHcons: NSLayoutConstraint!
    /// picView 的宽度约束
    @IBOutlet weak var picVIewWcons: NSLayoutConstraint!
    @IBOutlet weak var picViewBottomCons: NSLayoutConstraint!
    @IBOutlet weak var retweetContentBottomCons: NSLayoutConstraint!
    
    
    
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
    @IBOutlet weak var contentLabel: RELabel!
    /// 微博图片内容
    @IBOutlet weak var picView: PicCollectionView!
    /// 转发微博内容
    @IBOutlet weak var retweetContentLabel: RELabel!
    /// 转发微博背景
    @IBOutlet weak var retweetStatusBGView: UIView!
    /// 底部工具栏
    @IBOutlet weak var bottomToolBar: UIView!

    
    // MARK: - 系统回调
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 一次性设置内容Label的宽度，来以此准确的自动计算内容Label的高度。
        contentLabelWidthConstraint.constant = kScreenW - 2 * 15
        
        // 设置 picView 的 itemLayout 
//        let layout = picView.collectionViewLayout as! UICollectionViewFlowLayout
//        let imageViewWH : CGFloat = (kScreenW - 2 * edgeMargin - 2 * itemMargin) / 3
//        layout.itemSize = CGSize(width: imageViewWH, height: imageViewWH)
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
        
        
        // 1.没有配图
        if count == 0 {
            
            // 修改picView底部约束
            picViewBottomCons.constant = 0
            
            return CGSize.zero
        }
        
        // 修改picView底部约束
        picViewBottomCons.constant = 10
        
        // 2.取到collectionView的layout
        let layout = picView.collectionViewLayout as! UICollectionViewFlowLayout

        
        // 3.单张配图
        if count == 1 {
            
            // 3.1取出缓存图片，根据该图片的Size进行返回
            let imageurl = self.statusVM?.picURLs.first?.absoluteString
            
            let imageCache: SDImageCache = SDWebImageManager.shared.imageCache as! SDImageCache
            let image = imageCache.imageFromCache(forKey: imageurl)
            
            if let image = image
             {
                // 3.2 设置单张配图的layout.itemSize
                layout.itemSize = CGSize(width: ((image.size.width) * 2) > 150 ? 150 : ((image.size.width) * 2 ), height: (image.size.height) * 2 > 100 ? 100 : (image.size.height) * 2)
                // 3.3.返回对应的size
                return layout.itemSize
            }
            
        }
        
        // 4.计算多张配图imageView的WH
        let imageViewWH : CGFloat = (kScreenW - 2 * edgeMargin - 2 * itemMargin) / 3
        layout.itemSize = CGSize(width: imageViewWH, height: imageViewWH)

        
        // 5.张配图
        if count == 4 {
            let picViewWH = imageViewWH * 2 + itemMargin + 1
            return CGSize(width: picViewWH, height: picViewWH)
        }
        
        // 6.其他张数配图
        let rows = CGFloat((count - 1) / 3 + 1 )
        let picViewH = rows * imageViewWH + (rows - 1) * itemMargin
        let picViewW = kScreenW - 2 * edgeMargin
        
        return CGSize(width: picViewW, height: picViewH)
        
    }
}
