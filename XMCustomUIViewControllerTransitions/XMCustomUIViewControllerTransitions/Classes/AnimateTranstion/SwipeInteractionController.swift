//
//  SwipeInteractionController.swift
//  XMCustomUIViewControllerTransitions
//
//  Created by TwtMac on 17/1/22.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class SwipeInteractionController: UIPercentDrivenInteractiveTransition {

    var interactionInProgress: Bool?
    var shouldCompleteTransition: Bool = false
    var viewController: UIViewController?
    
    func wireToViewController(vc: UIViewController) {
        viewController = vc
    }
    
    private func prepareGestureRecognizerInView(view: UIView) {
        let edgePanGesture = UIScreenEdgePanGestureRecognizer.init(target: self, action: #selector(handleGesture))
        view.addGestureRecognizer(edgePanGesture)
    }
    
    @objc func handleGesture(gesture: UIScreenEdgePanGestureRecognizer) {
        let translation = gesture.translation(in: gesture.view)
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
                self.interactionInProgress = false
                if !self.shouldCompleteTransition {
                    self.cancel()
                } else {
                    self.finish()
                }
            default:
                break
        }
    }
    
}
