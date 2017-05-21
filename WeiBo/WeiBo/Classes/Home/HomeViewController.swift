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
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        isLogin = true
        
        // 未登录时候的页面
        visitorView.addRotationAnim()
        if !isLogin {
            return
        }
        
        // 登录之后的页面
        setupNavigationBar()
        
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
        
        // 2.弹出popover菜单
        let pop = PopoverViewController()
        
        // 3. 重要--设置Model样式为保留之前VC们
        pop.modalPresentationStyle = .custom
        
        // 4. 设置转场动画，改变对应的 popvc 的frame
        pop.transitioningDelegate = self 
 
        self.present(pop, animated: true, completion: nil)
    }
    
}


// MARK: - 自定义转场动画代理
extension HomeViewController : UIViewControllerTransitioningDelegate{
    
    /// 得到presentController，可可以修改对应的弹出view 的frame
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        
        // 这里需要自定义UIPresentationController
        return XYPresentationController(presentedViewController: presented, presenting: presenting)
    }
    
    
    /// 自定义弹出和消失的转场动画
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return self
    }
    
}



extension HomeViewController : UIViewControllerAnimatedTransitioning{
    
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval{
       
        return 2.0
    }
    
    /// 获取“转场动画上下文”，可以通过上下文获取弹出的View额消失的view
    // .to 要去的动画
    // .from 消失的动画
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning){
        
        let presentView = transitionContext.view(forKey: .to)
        
        
    }
    
    
}



