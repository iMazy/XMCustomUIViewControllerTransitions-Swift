//
//  FlipPresentAnimationController.swift
//  XMCustomUIViewControllerTransitions
//
//  Created by TwtMac on 17/1/22.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class FlipPresentAnimationController: NSObject {
    var originFrame =  CGRect.zero
}

extension FlipPresentAnimationController: UIViewControllerAnimatedTransitioning {
    /**
     模态呈现时间间隔
     
     @param transitionContext 转场上下文
     @return 返回时间间隔
     */
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1.0
    }
    
    /**
     控制动画
     
     @param transitionContext 转场上下文
     */
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        /// 容器视图
        let containerView = transitionContext.containerView
        /// 当前控制器/目标控制器
        guard let fromVC = transitionContext.viewController(forKey: .from),
            let toVC = transitionContext.viewController(forKey: .to) else {
                return
        }
        /// 初始大小
        let initialFrame = originFrame
        /// 最终大小
        let finialFrame = transitionContext.finalFrame(for: toVC)
        /// 目标控制器截屏(初始化之后的)
        let snapshot = AnimationHelper.getImage(view: toVC.view)
        /// 设置目标控制器的初始大小
        snapshot.frame = initialFrame
        /// 切圆角
        snapshot.layer.cornerRadius = 25
        snapshot.layer.masksToBounds = true
        /// 添加到容器视图中
        containerView.addSubview(toVC.view)
        containerView.addSubview(snapshot)
        /// 隐藏目标控制器视图
        toVC.view.isHidden = true
        /// 设置动画属性
        AnimationHelper.perspectiveTransformForContainerView(containerView: containerView)
        /// 默认让目标视图的截图 Y 轴 旋转180度
        snapshot.layer.transform = AnimationHelper.yRotation(angle: CGFloat(M_PI_2))
        /// 获取时间间隔
        let duration = transitionDuration(using: transitionContext)
        /// 1 定义 关键帧动画
        UIView.animateKeyframes(withDuration: duration, delay: 0, options: .calculationModeCubic, animations: {
            /// 2 添加关键帧动画1 - 让主控制器旋转 180 度
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.33, animations: { 
                fromVC.view.layer.transform = AnimationHelper.yRotation(angle: CGFloat(-M_PI_2))
            })
            /// 3 添加关键帧动画2 - 切换目标控制器的动画,让目标控制器截图旋转180度展示出来
            UIView.addKeyframe(withRelativeStartTime: 0.33, relativeDuration: 0.33, animations: { 
                snapshot.layer.transform = AnimationHelper.yRotation(angle: 0)
            })
            /// 4 添加关键帧动画3 - 设置目标控制器截屏的大小为最终屏幕
            UIView.addKeyframe(withRelativeStartTime: 0.66, relativeDuration: 0.33, animations: { 
                snapshot.frame = finialFrame
            })
            
        }) { (_) in
            /// 显示目标控制器
            toVC.view.isHidden = false
            /// 恢复根控制器的 transform 为初始状态
            fromVC.view.layer.transform = AnimationHelper.yRotation(angle: 0)
            /// 移除截屏
            snapshot.removeFromSuperview()
            /// 完成 模态跳转动画
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        
    }
    
}
