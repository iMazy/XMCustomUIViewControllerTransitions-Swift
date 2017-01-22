//
//  AnimationHelper.swift
//  XMCustomUIViewControllerTransitions
//
//  Created by TwtMac on 17/1/22.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class AnimationHelper: NSObject {
    class func yRotation(angle: CGFloat)->CATransform3D {
        return CATransform3DMakeRotation(angle, 0, 1.0, 0)
    }
    
    class func perspectiveTransformForContainerView(containerView: UIView) {
        var transform = CATransform3DIdentity
        transform.m34 = -0.002
        containerView.layer.sublayerTransform = transform
    }
    
    class func getImage(view: UIView) -> UIImageView {
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        
        UIGraphicsBeginImageContext(CGSize(width: width, height: height))
        if let content = UIGraphicsGetCurrentContext() {
            view.layer.render(in: content)
        }
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return UIImageView(image: image)
        
    }
}
