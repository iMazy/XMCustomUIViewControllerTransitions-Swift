//
//  FlipDismissAnimationController.swift
//  XMCustomUIViewControllerTransitions
//
//  Created by TwtMac on 17/1/22.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class FlipDismissAnimationController: NSObject {
    var destinationFrame =  CGRect.zero
}

extension FlipDismissAnimationController: UIViewControllerAnimatedTransitioning {
    
    /**
     模态呈现时间间隔
     
     @param transitionContext 转场上下文
     @return 返回时间间隔
     */
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.6
    }
    
    /**
     控制动画
     
     @param transitionContext 转场上下文
     */
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        /// 容器视图
        let containerView = transitionContext.containerView
        /// 当前控制器
        guard let fromVC = transitionContext.viewController(forKey: .from),
            let toVC = transitionContext.viewController(forKey: .to) else {
                return
        }
        /// 最终大小
        let finialFrame = destinationFrame
        /// 根控制器截屏(初始化之后的)
        let snapshot = AnimationHelper.getImage(view: fromVC.view)
        /// 切圆角
        snapshot.layer.cornerRadius = 25
        snapshot.layer.masksToBounds = true
        /// 添加到容器视图中
        containerView.addSubview(toVC.view)
        containerView.addSubview(snapshot)
        /// 隐藏根控制器视图
        fromVC.view.isHidden = true
        /// 设置动画属性
        AnimationHelper.perspectiveTransformForContainerView(containerView: containerView)
        /// 默认让目标视图的截图 Y 轴 旋转180度
        toVC.view.layer.transform = AnimationHelper.yRotation(angle: CGFloat(-M_PI_2))
        /// 获取时间间隔
        let duration = transitionDuration(using: transitionContext)
        /// 1 定义 关键帧动画
        UIView.animateKeyframes(withDuration: duration, delay: 0, options: .calculationModeCubic, animations: {
            /// 2 添加关键帧动画1 - 设置根控制器截屏的大小为最终大小
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.33, animations: {
                snapshot.frame = finialFrame
            })
            /// 3 添加关键帧动画2 - 设置根控制器截屏旋转180度隐藏
            UIView.addKeyframe(withRelativeStartTime: 0.33, relativeDuration: 0.33, animations: {
                snapshot.layer.transform = AnimationHelper.yRotation(angle: CGFloat(M_PI_2))
            })
            /// 4 添加关键帧动画1 - 让目标控制器旋转 180 度 展示出来
            UIView.addKeyframe(withRelativeStartTime: 0.66, relativeDuration: 0.33, animations: {
                toVC.view.layer.transform = AnimationHelper.yRotation(angle: 0)
            })
            
        }) { (_) in
            /// 显示目标控制器
            fromVC.view.isHidden = false
            /// 移除截屏
            snapshot.removeFromSuperview()
            /// 完成 模态跳转动画
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        
    }
    
}
