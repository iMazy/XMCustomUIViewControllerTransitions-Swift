//
//  SwipeInteractionController.swift
//  XMCustomUIViewControllerTransitions
//
//  Created by TwtMac on 17/1/22.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class SwipeInteractionController: UIPercentDrivenInteractiveTransition {

    var interactionInProgress: Bool = false
    var shouldCompleteTransition: Bool = false
    var viewController: UIViewController?
    
    func wireToViewController(vc: UIViewController) {
        viewController = vc
        prepareGestureRecognizerInView(view: vc.view)
    }
    
    private func prepareGestureRecognizerInView(view: UIView) {
        // 添加边缘手势
        let edgePanGesture = UIScreenEdgePanGestureRecognizer.init(target: self, action: #selector(handleGesture))
        // 设置手势位置为左边
        edgePanGesture.edges = .left
        view.addGestureRecognizer(edgePanGesture)
    }
    
    /**
     处理左划手势
     
     @param gestureRecognizer 手势
     */
    @objc func handleGesture(gesture: UIScreenEdgePanGestureRecognizer) {
        let translation = gesture.translation(in: gesture.view?.superview)
        var progress = translation.x/200
        progress = CGFloat(fminf(fmaxf(Float(progress), 0), 1.0))
        
        switch gesture.state {
            
            case .began:
                interactionInProgress = true
                viewController?.dismiss(animated: true, completion: nil)
            
            case .changed:
                shouldCompleteTransition = progress > 0.5
                update(progress)
            
            case .cancelled:
                interactionInProgress = false
                cancel()
            
            case .ended:
                interactionInProgress = false
                if !self.shouldCompleteTransition {
                    cancel()
                } else {
                    finish()
                }
            
            default:
                break
        }
    }
    
}
