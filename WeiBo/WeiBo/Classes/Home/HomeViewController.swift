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
import SVProgressHUD
//import 

class HomeViewController: BaseViewController {
    
    // MARK: - 懒加载属性
    fileprivate lazy var titleBtn : TitleButton = TitleButton()
    fileprivate lazy var tipLabel : UILabel = { [unowned self] in
        
        var tipLabel = UILabel()
        tipLabel.backgroundColor = UIColor.orange
        tipLabel.textColor = UIColor.white
        tipLabel.textAlignment = NSTextAlignment.center
        tipLabel.frame = CGRect(x: 10, y: 10, width: kScreenW - 20, height: 34)
        tipLabel.layer.cornerRadius = 5
        tipLabel.clipsToBounds = true
        tipLabel.isHidden = true
        return tipLabel
    }()
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
        
        // 自己计算cell高度
        tableView.estimatedRowHeight = 200
        
        // 添加自动刷新header、footer
        addRefreshComponent()
        
    
        // 添加通知
        setNotifications()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
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
    
    
    /// 添加通知
    fileprivate func setNotifications(){
        NotificationCenter.default.addObserver(self, selector: #selector(showPhotoBrowser(note:)) , name: ShowPhotoBrowserNote, object: nil)
    }
    
    @objc fileprivate func showPhotoBrowser(note : Notification){
        
        let indexPath = note.userInfo?[ShowPhotoBrowserIndexKey] as! IndexPath
        let urls = note.userInfo?[ShowPhotoBrowserUrlsKey] as! [URL]
    
        let photoBrowser = PhotoBrowserViewController(indexPath: indexPath , urls: urls )
        photoBrowser.modalPresentationStyle = .custom
        present(photoBrowser, animated: true, completion: nil)
     
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
            
        })
        
        // 2.上拉加载原来数据
        self.tableView.mj_footer = MJRefreshAutoFooter(refreshingBlock: {
            
            let label = UILabel(frame: CGRect(x: 10, y: 10, width: kScreenW - 20, height: 30))
            label.backgroundColor = UIColor.clear
            label.text = "正在加载更多数据..."
            label.textColor = UIColor.gray
            label.textAlignment = NSTextAlignment.center
            label.font = UIFont.boldSystemFont(ofSize: 13)
            self.tableView.mj_footer.addSubview(label)

            // 请求数据
            self.loadData(false)
        })
        
        
        // 3.每次进来直接进行下拉刷新操作
        self.tableView.mj_header.beginRefreshing()
        
    }
    
    
    /// 加载数据
    ///
    /// - Parameter isNewData: 是否加载新数据
    func loadData(_ isNewData : Bool) {
        
        // 获取since_id / max_id
        var since_id = 0
        var max_id = 0
        
        if isNewData {
            since_id = self.statusViewModels.first?.status.mid ?? 0
        }else{
            max_id = self.statusViewModels.last?.status.mid ?? 0
            max_id = max_id == 0 ? 0 : max_id - 1
        }
        
        NetworkTools.loadHomeData(since_id, max_id: max_id) { (result) in
            
            guard let statusArray = result else{
                
                // 这块说明没有值，请求超限
                self.tableView.mj_footer.endRefreshing()
                self.tableView.mj_header.endRefreshing()
                
                SVProgressHUD.showError(withStatus: "请求超限制次数")
                
                return
            }
            
            var tempViewModels = [StatusViewModel]()
            
            for dict in statusArray{
                
                let status = Status(dict : dict)
                
                tempViewModels.append(StatusViewModel(status: status))
            }
            
            if isNewData{
                self.statusViewModels = tempViewModels + self.statusViewModels
                
                // 加载完数据进行图片数据的缓存，
                self.cacheImage(isNewData: true , count: tempViewModels.count,viewModels: self.statusViewModels)

            }else{
                self.statusViewModels += tempViewModels
                
                // 加载完数据进行图片数据的缓存，
                self.cacheImage(isNewData: false , count: tempViewModels.count,viewModels: self.statusViewModels)

            }

        }
        
    }
    
    fileprivate func cacheImage(isNewData : Bool ,count : Int ,  viewModels : [StatusViewModel]){
        
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
            
            self.tableView.mj_header.endRefreshing()
            self.tableView.mj_footer.endRefreshing()
            
            Dlog("刷新数据")
            
            if isNewData{
                
                self.showTipLabel(count: count)
            }
        }
    }
    
    
    fileprivate func showTipLabel(count : Int){
        
        // 展示tipLabel
        if count == 0{
            self.tipLabel.text = "无最新微博"
        }else{
            self.tipLabel.text = "更新\(count)条数据"
        }
        
        self.tipLabel.isHidden = false
        let bgview = UIView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: 44))
        bgview.backgroundColor = UIColor.white
        navigationController?.navigationBar.insertSubview(bgview, at: 0)
        navigationController?.navigationBar.insertSubview(self.tipLabel, at: 0)
        
        UIView.animate(withDuration: 1.5, animations: {
            
            // 慢慢展示
            self.tipLabel.transform = CGAffineTransform(translationX: 0, y: 44)
            
        }, completion: { (_) in
            
            // 慢慢消失
            UIView.animate(withDuration: 1.5, delay: 1.0, options: [], animations: {
                self.tipLabel.transform = CGAffineTransform.identity
            }, completion: { (_) in
                self.tipLabel.isHidden = true
            })
        })

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


