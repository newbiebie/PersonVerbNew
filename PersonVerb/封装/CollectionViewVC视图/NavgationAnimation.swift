//
//  NavgationAnimation.swift
//  PersonVerb
//
//  Created by GongHua Guo on 2018/9/10.
//  Copyright © 2018年 GongHua Guo. All rights reserved.
//

import UIKit

//定义枚举， 区分push pop
enum NavgationAnimationType : Int {
    case push = 0
    case pop = 1
}

/**
 过度动画创建
 */
class NavgationAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    
    private var type : NavgationAnimationType = NavgationAnimationType.push
    
    init(type : NavgationAnimationType) {
        super.init()
        
        self.type = type;
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1.0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        switch self.type {
        case .push:
            self.pushAnimation(context: transitionContext )
        default:
            self.popAnimation(context: transitionContext )
        }
    }
    
    /**
     push的时候调用
     */
    func pushAnimation(context : UIViewControllerContextTransitioning){
        let fromVC : CollectionViewVCViewController = context.viewController(forKey: .from) as! CollectionViewVCViewController
        let toVC : SecondViewController = context.viewController(forKey: .to) as! SecondViewController
        
        let containerView = context.containerView
        
        let indexPath = fromVC.collectionView?.indexPathsForSelectedItems!.first
        fromVC.selectedIndex = indexPath!
        
        let selectedCell = fromVC.collectionView?.cellForItem(at: indexPath!) as! VCViewCell
        let snapView = selectedCell.iconImage.snapshotView(afterScreenUpdates: false)
        
        snapView?.frame = containerView.convert(selectedCell.iconImage.frame, from: selectedCell.iconImage.superview)
        fromVC.finalrect = snapView!.frame
        print(fromVC.finalrect!)
        toVC.view.frame = context.finalFrame(for: toVC)
        toVC.view.alpha = 0
        toVC.imageView?.isHidden = true
        
        containerView.addSubview(toVC.view)
        containerView.addSubview(snapView!)
        
        //开始动画
        UIView.animate(withDuration: self.transitionDuration(using: context), delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 1.0, options: .curveLinear, animations: {
            toVC.view.alpha = 1.0
            snapView?.frame = containerView.convert(toVC.imageView!.frame, to: toVC.imageView?.superview)
        }) { (isCompletion) in
            snapView?.removeFromSuperview()
            toVC.imageView?.isHidden = false
            context.completeTransition(!context.transitionWasCancelled)
        }
    }
    
    /**
     pop的时候调用
     */
    func popAnimation(context : UIViewControllerContextTransitioning){
        let ToVC : CollectionViewVCViewController = context.viewController(forKey: .to) as! CollectionViewVCViewController
        let fromVC : SecondViewController = context.viewController(forKey: .from) as! SecondViewController
        
        let containerView = context.containerView
        
        let snapView = fromVC.imageView?.snapshotView(afterScreenUpdates: false)
        snapView?.backgroundColor = .clear
        snapView?.frame = containerView.convert(fromVC.imageView!.frame, from: fromVC.imageView?.superview)
        
        //获取图片终点的frame
        let cell = ToVC.collectionView?.cellForItem(at: ToVC.selectedIndex!) as! VCViewCell
        cell.iconImage.isHidden = true
        ToVC.view.frame = context.finalFrame(for: ToVC)
        
        containerView.insertSubview(ToVC.view, belowSubview: fromVC.view)
        containerView.addSubview(snapView!)
        
        
        //开始动画
        UIView.animate(withDuration: self.transitionDuration(using: context), delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 1.0, options: .curveLinear, animations: {
            fromVC.view.alpha = 0
            snapView?.frame = ToVC.finalrect!
        }) { (isCompletion) in
            snapView?.removeFromSuperview()
            cell.iconImage.isHidden = false
            context.completeTransition(!context.transitionWasCancelled)
        }
    }
}
