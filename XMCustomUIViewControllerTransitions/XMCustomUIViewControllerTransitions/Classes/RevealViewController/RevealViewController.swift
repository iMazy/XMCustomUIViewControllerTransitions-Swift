//
//  RevealViewController.swift
//  XMCustomUIViewControllerTransitions
//
//  Created by TwtMac on 17/1/22.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class RevealViewController: UIViewController {
    
    var yachtCard: YachtCard?
    
    @IBOutlet weak var pictureView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = yachtCard?.name
        pictureView.image = UIImage(named: yachtCard?.image ?? "")
    }

    @IBAction func gameOverAction() {
        dismiss(animated: true, completion: nil)
    }


}
