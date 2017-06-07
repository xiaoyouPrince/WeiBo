//
//  HomeViewController.swift
//  WeiBo
//
//  Created by 渠晓友 on 2017/5/19.
//  Copyright © 2017年 xiaoyouPrince. All rights reserved.
//

import UIKit
import SDWebImage
import MJRefresh

class HomeViewController: BaseViewController {
    
    // MARK: - 懒加载属性
    fileprivate lazy var titleBtn : TitleButton = TitleButton()
    fileprivate lazy var popoverAnimator : PopoverAnimator = PopoverAnimator {[unowned self] (dismissFinished) in
        self.titleBtn.isSelected = dismissFinished
    }
    
    var statusViewModels : [StatusViewModel] = [StatusViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 未登录时候的页面
        visitorView.addRotationAnim()
        if !isLogin {
            return
        }
        
        // 登录之后的页面
        setupNavigationBar()
        
        
//        // 请求数据
//        loadData()
        
        // 自己计算cell高度
        tableView.estimatedRowHeight = 200
        
        // 添加自动刷新header、footer
        addRefreshComponent()
    
    }
}


// MARK: - 创建UI
extension HomeViewController{
    
    /// buildUI
    func buildUI() {
        
        
        
        setupNavigationBar()
    }
    
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

// MARK: - 加载数据
extension HomeViewController{
    
    
    /// 添加上拉加载和下拉刷新功能
    func addRefreshComponent() {
        
        // 1.下拉刷新数据
        self.tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            // 请求数据
            self.loadData(true)
            
            self.tableView.mj_header.endRefreshing()
        })
        
//        // 2.上拉加载原来数据
//        self.tableView.mj_footer = MJRefreshBackFooter(refreshingBlock: { 
//            self.tableView.mj_footer.endRefreshing()
//
//        })
        // 3.每次进来直接进行下拉刷新操作
        self.tableView.mj_header.beginRefreshing()
        
    }
    
    
    func loadData(_ isNewData : Bool) {
        
        
        // 获取since_id
        var since_id = 0
        
        if isNewData {
            
            since_id = self.statusViewModels.first?.status.mid ?? 0
        }
        
        NetworkTools.loadHomeData("\(since_id)") { (result) in
            
            guard let statusArray = result else{return}
            
            var tempViewModels = [StatusViewModel]()
            
            for dict in statusArray{
                
                let status = Status(dict : dict)
                
//                self.statusViewModels.append(StatusViewModel(status: status))
                
                tempViewModels.append(StatusViewModel(status: status))
            }
            
            self.statusViewModels = tempViewModels + self.statusViewModels
    
            // 加载完数据进行图片数据的缓存，
            
            self.cacheImage(viewModels: self.statusViewModels)
            
        }
        
    }
    
    fileprivate func cacheImage(viewModels : [StatusViewModel]){
        
        // 异步下载图片之后，再进行刷新表格，通过组来完成
        let group = DispatchGroup.init()

        
        
        for viewModel in viewModels {
            for url in viewModel.picURLs {
                
                group.enter()
                SDWebImageManager.shared().loadImage(with: url, options: [], progress: nil, completed: { (_, _, _, _, _, _) in

                    Dlog("图片下载完")
                    group.leave()
                })
            }
        }

        group.notify(queue: DispatchQueue.main) {
            
            self.tableView.reloadData()
            Dlog("刷新数据")
        }
    }
    
}


// MARK: - tableView展示数据
extension HomeViewController{
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.statusViewModels.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "homeCell") as! HomeViewCell
        
        cell.statusVM = self.statusViewModels[indexPath.row]
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //手动计算cell高度
        
        let viewModel = self.statusViewModels[indexPath.row]
    
        return viewModel.cellHeight
    }
    
}



