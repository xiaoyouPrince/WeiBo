//
//  BaseViewController.swift
//  WeiBo
//
//  Created by 渠晓友 on 2017/5/19.
//  Copyright © 2017年 xiaoyouPrince. All rights reserved.
//

import UIKit

class BaseViewController: UITableViewController {
    
    // MARK: - 懒加载visitorView
    fileprivate lazy var visitorView : VisitorView = VisitorView.visitorView()
    
    /// 属性： 是否登录
    var isLogin : Bool = false
    
    
    // MARK: - 系统调用
    override func loadView() {
        
        isLogin ? super.loadView() : setupVisitorView()
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    
    
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }


}


// MARK: - 创建访客视图
extension BaseViewController {
    
    
    fileprivate func setupVisitorView(){
                
        view = visitorView
        
    }
    
}

