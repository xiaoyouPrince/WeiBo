//
//  PicPickerView.swift
//  WeiBo
//
//  Created by 渠晓友 on 2017/6/9.
//  Copyright © 2017年 xiaoyouPrince. All rights reserved.
//

import UIKit

private let picPickerCellID = "picPickerCellID"
private let margin : CGFloat = 15

class PicPickerView: UICollectionView {
    
    // MARK: - 属性
    var images : [UIImage] = [UIImage]() {
        didSet{
            reloadData()
        }
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
//        delegate = self
        dataSource = self
        
        // MARK: - 设置自己布局
        setupItemLayout()
        
        // 注册cell
        self.register(UINib(nibName: "PicPickerCell", bundle: nil) , forCellWithReuseIdentifier: picPickerCellID)
    }

}


// MARK: - 设置UI
extension PicPickerView{
    
    
    /// 设置内部的布局
    fileprivate func setupItemLayout(){
        
        let layout = self.collectionViewLayout as! UICollectionViewFlowLayout
        let itemW = (kScreenW - 4 * margin) / 3
        let itemH = itemW
        layout.itemSize = CGSize(width: itemW, height: itemH)
        layout.minimumLineSpacing = margin
        layout.minimumInteritemSpacing = margin
        
        self.contentInset = UIEdgeInsetsMake(margin, margin, 0, margin)
    }
    
}


// MARK: - 代理方法和数据源方法
extension PicPickerView : UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: picPickerCellID , for: indexPath) as! PicPickerCell
        
        cell.image = indexPath.item <= images.count - 1 ? images[indexPath.item] : nil
        
        return cell
        
    }
    
}
