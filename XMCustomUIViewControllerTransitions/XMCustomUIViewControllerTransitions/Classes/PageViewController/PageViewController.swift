//
//  PageViewController.swift
//  XMCustomUIViewControllerTransitions
//
//  Created by TwtMac on 17/1/22.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {
    
    var yachtCards:[YachtCard] {
        return YachtCardStore.defaultBeauties()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = self
        
        setViewControllers([viewControllerAtIndex(index: 0)], direction: .forward, animated: true, completion: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func viewControllerAtIndex(index: Int) -> UIViewController {
        let cardVC = CardViewController()
        cardVC.pageIndex = index
        cardVC.yachtCard = yachtCards[index]
        return cardVC
    }
    

}

extension PageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let cardVC = viewController as! CardViewController
        if cardVC.pageIndex > 0 {
            return viewControllerAtIndex(index: cardVC.pageIndex - 1)
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let cardVC = viewController as! CardViewController
        if cardVC.pageIndex < yachtCards.count-1 {
            return viewControllerAtIndex(index: cardVC.pageIndex + 1)
        }
        return nil
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return yachtCards.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
}
