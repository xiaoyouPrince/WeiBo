//
//  PhotoBrowserViewController.swift
//  WeiBo
//
//  Created by 渠晓友 on 2017/6/13.
//  Copyright © 2017年 xiaoyouPrince. All rights reserved.
//

import UIKit
import SDWebImage
import SnapKit
import SVProgressHUD

class PhotoBrowserViewController: UIViewController {
    
    // MARK: - 属性
    var indexPath : IndexPath?
    var urls : [URL]?
    
    // MARK:- 懒加载属性
    fileprivate lazy var collectionView : UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: PhotoBrowserCollectionViewLayout())
    fileprivate lazy var closeBtn : UIButton = UIButton(bgColor: UIColor.darkGray, fontSize: 14, title: "关 闭")
    fileprivate lazy var saveBtn : UIButton = UIButton(bgColor: UIColor.darkGray, fontSize: 14, title: "保 存")
    
    
    
    init(indexPath : IndexPath , urls : [URL]){
        
        self.indexPath = indexPath
        self.urls = urls
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    override func loadView() {
        super.loadView()
        
        view.frame.size.width += 20
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
    }

}


// MARK: - 创建UI

extension PhotoBrowserViewController{
    
    fileprivate func setupUI() {
        // 1.添加子控件
        view.addSubview(collectionView)
        view.addSubview(closeBtn)
        view.addSubview(saveBtn)
        
        // 2.设置frame
        collectionView.frame = view.bounds
        closeBtn.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(20)
            make.bottom.equalTo(-20)
            make.size.equalTo(CGSize(width: 90, height: 32))
        }
        saveBtn.snp.makeConstraints { (make) -> Void in
            make.right.equalTo(-40)
            make.bottom.equalTo(closeBtn.snp.bottom)
            make.size.equalTo(closeBtn.snp.size)
        }
        
        // 3.设置collectionView的属性
        collectionView.register(PhotoBrowserViewCell.self, forCellWithReuseIdentifier: PhotoBrowserCell)
        collectionView.dataSource = self
        
        // 4.监听两个按钮的点击
        closeBtn.addTarget(self, action: #selector(closeBtnClick), for: .touchUpInside)
        saveBtn.addTarget(self, action: #selector(saveBtnClick), for: .touchUpInside)
    }

}

// MARK:- 事件监听函数

extension PhotoBrowserViewController {
    @objc fileprivate func closeBtnClick() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc fileprivate func saveBtnClick() {
        // 1.获取当前正在显示的image
        let cell = collectionView.visibleCells.first as! PhotoBrowserViewCell
        guard let image = cell.imageView.image else {
            return
        }
        
        // 2.将image对象保存相册
        UIImageWriteToSavedPhotosAlbum(image, self, "image:didFinishSavingWithError:contextInfo:", nil)
    }
    
    @objc private func image(image : UIImage, didFinishSavingWithError error : NSError?, contextInfo : AnyObject) {
        var showInfo = ""
        if error != nil {
            showInfo = "保存失败"
        } else {
            showInfo = "保存成功"
        }
        
        SVProgressHUD.showInfo(withStatus: showInfo)
    }
}


// MARK: - UICollectionViewDataSource

extension PhotoBrowserViewController : UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return (urls?.count)!
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoBrowserCell, for: indexPath)
        
        
        return cell
    }
}




class PhotoBrowserCollectionViewLayout: UICollectionViewFlowLayout {
    
    override func prepare() {
        super.prepare()
        
        
        itemSize = (collectionView?.frame.size)!
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
        scrollDirection = .horizontal

        collectionView?.isPagingEnabled = true
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.showsHorizontalScrollIndicator = false
        
    }
    
}
