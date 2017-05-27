//
//  HomeViewController.swift
//  WeiBo
//
//  Created by 渠晓友 on 2017/5/19.
//  Copyright © 2017年 xiaoyouPrince. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {
    
    // MARK: - 懒加载属性
    fileprivate lazy var titleBtn : TitleButton = TitleButton()
    fileprivate lazy var popoverAnimator : PopoverAnimator = PopoverAnimator {[unowned self] (dismissFinished) in
        self.titleBtn.isSelected = dismissFinished
    }
    
//    var statuses : [Status] = [Status]()
    var statusViewModels : [StatusViewModel] = [StatusViewModel]()
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        isLogin = true
        
        // 未登录时候的页面
        visitorView.addRotationAnim()
        if !isLogin {
            return
        }
        
        // 登录之后的页面
        setupNavigationBar()
        
        
        // 请求数据
        loadData()
        
    }
}


// MARK: - 创建UI

extension HomeViewController{
    
    /// 设置导航栏
    func setupNavigationBar() {
        
        // 导航栏左右item
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "navigationbar_friendattention")
        navigationItem.rightBarButtonItem = UIBarButtonItem(imageName: "navigationbar_pop")
        
        // 导航栏titleBtn
        titleBtn.setTitle("xiaoyouPrince", for: .normal)
        titleBtn.addTarget(self, action: #selector(HomeViewController.titleBtnClick(titleBtn:)), for: .touchUpInside)
        navigationItem.titleView = titleBtn
    }
}


// MARK: - 监听事件监听

extension HomeViewController{
    
    
    @objc fileprivate func titleBtnClick(titleBtn : TitleButton) {
        
        // 1. 修改对应状态
        titleBtn.isSelected = !titleBtn.isSelected
        
        // 2. 弹出popover菜单
        let pop = PopoverViewController()
        
        // 3. 重要--设置Model样式为保留之前VC们
        pop.modalPresentationStyle = .custom
        
        // 4. 设置转场动画，改变对应的 popvc 的frame
        pop.transitioningDelegate = popoverAnimator
 
        self.present(pop, animated: true, completion: nil)
        
    }
    
}


extension HomeViewController{
    
    func loadData() {
        
        NetworkTools.loadHomeData { (result) in
            
            guard let statusArray = result else{return}
            
            for dict in statusArray{
                
                let status = Status(dict : dict)
                
//                self.statuses.append(status)
                self.statusViewModels.append(StatusViewModel(status: status))
            }
    
            self.tableView.reloadData()
        }
        
    }
    
}


// MARK: - tableView展示数据
extension HomeViewController{
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.statuses.count
        return self.statusViewModels.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "homeCell")!
        
//        let status = self.statuses[indexPath.row]
        let statusVm = self.statusViewModels[indexPath.row]
        
        
//        cell.textLabel?.text = status.sourceText
//        cell.detailTextLabel?.text = status.user?.screen_name
        cell.textLabel?.text = statusVm.sourceText
        cell.detailTextLabel?.text = statusVm.creatTimeStr
        
        return cell
        
    }
    
}



