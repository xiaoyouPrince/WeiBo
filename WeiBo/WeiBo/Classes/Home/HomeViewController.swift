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
    
    // 用来判断是是不是弹出动画
    fileprivate var isPresent : Bool = false
    
    

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
        
        isPresent = true
        
        return self
    }
    
    /// 自定义消失的转场动画
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        
        isPresent = false
        return self
    }
    
}



// MARK: - 弹出动画和消失动画的代理

extension HomeViewController : UIViewControllerAnimatedTransitioning{
    
    
    /// 返回动画时间
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval{
       
        return 0.5
    }
    
    /// 获取“转场动画上下文”，可以通过上下文获取弹出的View额消失的view
    // .to 要去的动画
    // .from 消失的动画
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning){
        
        isPresent ? animateForPresent(transitionContext: transitionContext) : animateForDismiss(transitionContext: transitionContext)
  
    }
    
    
    /// 自定义弹出动画
    func animateForPresent(transitionContext: UIViewControllerContextTransitioning) {
        
        // 得到要去的view
        let presentView = transitionContext.view(forKey: .to)
        
        // 添加到Model的ContainerView中去
        transitionContext.containerView.addSubview(presentView!)
        
        // 执行对应动画
        presentView?.transform = CGAffineTransform(scaleX: 1.0, y: 0.0)
        presentView?.layer.anchorPoint = CGPoint(x: 0.5, y: 0)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: { () -> Void in
            presentView?.transform = CGAffineTransform.identity
        }, completion: { (_) -> Void in
            // 必须告诉转场上下文你已经完成动画
            transitionContext.completeTransition(true)
        })
    }
    
    
    /// 自定义弹出动画
    func animateForDismiss(transitionContext: UIViewControllerContextTransitioning) {
        
        // 得到要去的view
        let presentView = transitionContext.view(forKey: .from)
        
        // 添加到Model的ContainerView中去
        transitionContext.containerView.addSubview(presentView!)
        
        // 执行对应动画
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: { () -> Void in
            
            presentView?.transform = CGAffineTransform(scaleX: 1.0, y: 0.0001)

        }, completion: { (_) -> Void in
            
            // 移除View并告诉上下文已经完成动画
            presentView?.removeFromSuperview()
            transitionContext.completeTransition(true)
        })
    }
    
    
}



