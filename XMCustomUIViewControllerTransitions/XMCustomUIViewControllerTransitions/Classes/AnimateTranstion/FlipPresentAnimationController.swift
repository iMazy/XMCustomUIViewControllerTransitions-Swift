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
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1.0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        
        guard let fromVC = transitionContext.viewController(forKey: .from),
            let toVC = transitionContext.viewController(forKey: .to) else {
                return
        }
        
        let snapshot = AnimationHelper.getImage(view: toVC.view)
        
        let initialFrame = originFrame
        let finialFrame = transitionContext.finalFrame(for: toVC)
        
        snapshot.frame = initialFrame
        snapshot.layer.cornerRadius = 25
        snapshot.layer.masksToBounds = true
        containerView.addSubview(toVC.view)
        containerView.addSubview(snapshot)
        
        toVC.view.isHidden = true
        
        AnimationHelper.perspectiveTransformForContainerView(containerView: containerView)
        snapshot.layer.transform = AnimationHelper.yRotation(angle: CGFloat(M_PI_2))
        
        let duration = transitionDuration(using: transitionContext)
        
        UIView.animateKeyframes(withDuration: duration, delay: 0, options: .calculationModeCubic, animations: { 
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.33, animations: { 
                fromVC.view.layer.transform = AnimationHelper.yRotation(angle: CGFloat(-M_PI_2))
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0.33, relativeDuration: 0.33, animations: { 
                snapshot.layer.transform = AnimationHelper.yRotation(angle: 0)
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0.66, relativeDuration: 0.33, animations: { 
                snapshot.frame = finialFrame
            })
            
        }) { (_) in
            toVC.view.isHidden = false
            fromVC.view.layer.transform = AnimationHelper.yRotation(angle: 0)
            snapshot.removeFromSuperview()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        
    }
    
}
