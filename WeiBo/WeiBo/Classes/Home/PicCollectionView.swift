//
//  PicCollectionView.swift
//  WeiBo
//
//  Created by 渠晓友 on 2017/6/5.
//  Copyright © 2017年 xiaoyouPrince. All rights reserved.
//
//  封装一个picCollectionView自己管理pic的展示

import UIKit
import SDWebImage

class PicCollectionView: UICollectionView {

    var picUrls : [URL] = [URL](){
        didSet{
            self.reloadData()
        }
    }
    

    // MARK: - 系统回调
    override func awakeFromNib() {
        super.awakeFromNib()
        
        dataSource = self
        delegate = self
    }
}

extension PicCollectionView : UICollectionViewDataSource , UICollectionViewDelegate{
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return picUrls.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        let cell = self.dequeueReusableCell(withReuseIdentifier: "picCell", for: indexPath) as! PicCollectionViewCell
        
        cell.picUrl = picUrls[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let userInfo = [ShowPhotoBrowserIndexKey : indexPath , ShowPhotoBrowserUrlsKey : self.picUrls] as [String : Any]
        // 发送通知
        NotificationCenter.default.post(name: ShowPhotoBrowserNote, object: self, userInfo: userInfo)
    }

}


class PicCollectionViewCell: UICollectionViewCell {
    
    // MARK: - 控件属性
    @IBOutlet weak var iconImageView: UIImageView!
    
    // MARK: - 模型属性
    var picUrl : URL? {
        didSet{
            
            guard let url = picUrl else {  return  }
            iconImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "empty_picture"))
         }
    }
}
