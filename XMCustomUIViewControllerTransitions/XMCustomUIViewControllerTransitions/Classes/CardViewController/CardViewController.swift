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
        present(vc, animated: true, completion: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
