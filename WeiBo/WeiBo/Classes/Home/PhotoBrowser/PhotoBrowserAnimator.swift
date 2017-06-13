//
//  PhotoBrowserAnimator.swift
//  WeiBo
//
//  Created by 渠晓友 on 2017/6/13.
//  Copyright © 2017年 xiaoyouPrince. All rights reserved.
//

import UIKit

// 面向协议开发
protocol AnimatorPresentedDelegate : NSObjectProtocol {
    func startRect(indexPath : IndexPath) -> CGRect
    func endRect(indexPath : IndexPath) -> CGRect
    func imageView(indexPath : IndexPath) -> UIImageView
}

protocol AnimatorDismissDelegate : NSObjectProtocol {
    func indexPathForDimissView() -> IndexPath
    func imageViewForDimissView() -> UIImageView
}


class PhotoBrowserAnimator: NSObject {
    var isPresented : Bool = false
    
    var presentedDelegate : AnimatorPresentedDelegate?
    var dismissDelegate : AnimatorDismissDelegate?
    var indexPath : IndexPath?

}


extension PhotoBrowserAnimator : UIViewControllerTransitioningDelegate {
    
    /// 自定义弹出和消失的转场动画
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        isPresented = true
        
        return self
    }
    
    /// 自定义消失的转场动画
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        
        isPresented = false
        
        return self
    }
}

extension PhotoBrowserAnimator : UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.25
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        isPresented ? animationForPresentedView(transitionContext: transitionContext) : animationForDismissView(transitionContext: transitionContext)
    }
    
    func animationForPresentedView(transitionContext: UIViewControllerContextTransitioning) {
        // 0.nil值校验
        guard let presentedDelegate = presentedDelegate, let indexPath = indexPath else {
            return
        }
        
        // 1.取出弹出的View
        let presentedView = transitionContext.view(forKey: UITransitionContextViewKey.to)!
        
        // 2.将prensentedView添加到containerView中
        transitionContext.containerView.addSubview(presentedView)
        
        // 3.获取执行动画的imageView
        let startRect = presentedDelegate.startRect(indexPath: indexPath )
        let imageView = presentedDelegate.imageView(indexPath: indexPath )
        transitionContext.containerView.addSubview(imageView)
        imageView.frame = startRect
        
        // 4.执行动画
        presentedView.alpha = 0.0
        transitionContext.containerView.backgroundColor = UIColor.black
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: { () -> Void in
            imageView.frame = presentedDelegate.endRect(indexPath: indexPath as IndexPath)
        }) { (_) -> Void in
            imageView.removeFromSuperview()
            presentedView.alpha = 1.0
            transitionContext.containerView.backgroundColor = UIColor.clear
            transitionContext.completeTransition(true)
        }
    }
    
    func animationForDismissView(transitionContext: UIViewControllerContextTransitioning) {
        // nil值校验
        guard let dismissDelegate = dismissDelegate, let presentedDelegate = presentedDelegate else {
            return
        }
        
        // 1.取出消失的View
        let dismissView = transitionContext.view(forKey: UITransitionContextViewKey.from)
        dismissView?.removeFromSuperview()
        
        // 2.获取执行动画的ImageView
        let imageView = dismissDelegate.imageViewForDimissView()
        transitionContext.containerView.addSubview(imageView)
        let indexPath = dismissDelegate.indexPathForDimissView()
        
        // 3.执行动画
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: { () -> Void in
            imageView.frame = presentedDelegate.startRect(indexPath: indexPath)
        }) { (_) -> Void in
            transitionContext.completeTransition(true)
        }
    }
}
