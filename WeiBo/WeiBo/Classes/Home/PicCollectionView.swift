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


extension PicCollectionView : AnimatorPresentedDelegate {
    func startRect(indexPath: IndexPath) -> CGRect {
        // 1.获取cell
        let cell = self.cellForItem(at: indexPath as IndexPath)!
        
        // 2.获取cell的frame
        let startFrame = self.convert(cell.frame, to: UIApplication.shared.keyWindow)
        
        return startFrame
    }
    
    func endRect(indexPath: IndexPath) -> CGRect {
        // 1.获取该位置的image对象
        let picURL = picUrls[indexPath.item]
        let image = SDWebImageManager.shared().imageCache?.imageFromCache(forKey: picURL.absoluteString)
        
        
        // 2.计算结束后的frame
        let w = UIScreen.main.bounds.width
        let h = w / (image?.size.width)! * (image?.size.height)!
        var y : CGFloat = 0
        if h > UIScreen.main.bounds.height {
            y = 0
        } else {
            y = (UIScreen.main.bounds.height - h) * 0.5
        }
        
        return CGRect(x: 0, y: y, width: w, height: h)
    }
    
    func imageView(indexPath: IndexPath) -> UIImageView {
        // 1.创建UIImageView对象
        let imageView = UIImageView()
        
        // 2.获取该位置的image对象
        let picURL = picUrls[indexPath.item]
        let image = SDWebImageManager.shared().imageCache?.imageFromDiskCache(forKey: picURL.absoluteString)
        
        // 3.设置imageView的属性
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
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
