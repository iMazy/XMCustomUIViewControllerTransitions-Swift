//
//  CardViewController.swift
//  XMCustomUIViewControllerTransitions
//
//  Created by TwtMac on 17/1/22.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class CardViewController: UIViewController {
    
    var pageIndex: Int = 0
    var yachtCard: YachtCard?
    
    /// 定义/初始化工具类
    let flipPresentAnimationController = FlipPresentAnimationController()
    let flipDismissAnimationController = FlipDismissAnimationController()
    let swipeInteractionController = SwipeInteractionController()
    
    @IBOutlet weak var cardView: UIView!
    
    @IBOutlet weak var descLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        cardView.layer.cornerRadius = 25
        cardView.layer.masksToBounds = true
        
        descLabel.text = yachtCard?.desc
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        cardView.addGestureRecognizer(tap)
    }
    
    @objc private func tapAction() {
        let vc = RevealViewController()
        vc.yachtCard = yachtCard
        /// 设置模态跳转的代理方法
        vc.transitioningDelegate = self
        /// 设置需要手势的控制器
        swipeInteractionController.wireToViewController(vc: vc)
        present(vc, animated: true, completion: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension CardViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        flipPresentAnimationController.originFrame = cardView.frame
        return flipPresentAnimationController
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        flipDismissAnimationController.destinationFrame = cardView.frame
        return flipDismissAnimationController
    }
    
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return swipeInteractionController.interactionInProgress ? swipeInteractionController : nil
    }
}
