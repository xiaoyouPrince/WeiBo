//
//  ComposeViewController.swift
//  WeiBo
//
//  Created by 渠晓友 on 2017/6/8.
//  Copyright © 2017年 xiaoyouPrince. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {
    
    // MARK: - 属性
    @IBOutlet weak var textView: ComposeTextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNav()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        textView.delegate = self
        textView.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        textView.resignFirstResponder()
    }
    
}


// MARK: - 设置UI
extension ComposeViewController{
    
    
    /// 设置导航栏
    fileprivate func setupNav(){
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", style: .plain, target: self, action: #selector(cancelItemClick))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "发布", style: .plain, target: self, action: #selector(commitItemClick))
        navigationItem.rightBarButtonItem?.isEnabled = false

        navigationItem.titleView = ComposeTitleView(frame: CGRect(x: 0, y: 0, width: kScreenW / 2, height: 40))
        
    }
    
   
}


// MARK: - 事件监听
extension ComposeViewController{
    
    @objc fileprivate func cancelItemClick(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc fileprivate func commitItemClick(){
        
    }
    
}



// MARK: - textView 的代理方法
extension ComposeViewController : UITextViewDelegate{
    
    func textViewDidChange(_ textView: UITextView) {

        self.textView.label.isHidden = textView.hasText
        navigationItem.rightBarButtonItem?.isEnabled = textView.hasText
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        textView.resignFirstResponder()
    }
}
