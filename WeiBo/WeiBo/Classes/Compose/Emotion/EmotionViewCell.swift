//
//  EmotionViewCell.swift
//  WeiBo
//
//  Created by 渠晓友 on 2017/6/11.
//  Copyright © 2017年 xiaoyouPrince. All rights reserved.
//

import UIKit

class EmotionViewCell: UICollectionViewCell {
    
    // MARK: - 懒加载属性
    fileprivate lazy var emotionBtn : UIButton = UIButton()
    
    // MARK: - 属性模型
    var emotion : Emotion?{
        didSet{
            
            guard let emotion = emotion else {
                return
            }
            
            emotionBtn.setImage(UIImage(contentsOfFile: emotion.pngPath ?? ""), for: .normal)
            Dlog(emotion.pngPath ?? "这里没有找到")
            emotionBtn.setTitle(emotion.emojiCode, for: .normal)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


// MARK: - 设置UI
extension EmotionViewCell{
    
    func setupUI() {
        
        self.contentView.addSubview(emotionBtn)
        emotionBtn.frame = self.bounds
        emotionBtn.titleLabel?.font = UIFont.systemFont(ofSize: 32)
    }
    
}
