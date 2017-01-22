//
//  AnimationHelper.swift
//  XMCustomUIViewControllerTransitions
//
//  Created by TwtMac on 17/1/22.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class AnimationHelper: NSObject {
    /**
     设置 y轴 旋转角度
     
     @param angle 旋转角度
     @return CATransform3D
     */
    class func yRotation(angle: CGFloat)->CATransform3D {
        return CATransform3DMakeRotation(angle, 0, 1.0, 0)
    }
    
    /**
     设置 子视图的动画属性
     
     @param containerView 容器视图
     */
    class func perspectiveTransformForContainerView(containerView: UIView) {
        var transform = CATransform3DIdentity
        transform.m34 = -0.002
        containerView.layer.sublayerTransform = transform
    }
    
    /**
     通过给定的视图获取当前视图的截屏图像
     
     @param view 需要截图的视图
     @return 返回 UIImageView
     */
    class func getImage(view: UIView) -> UIImageView {
        /// 宽/高度
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        /// 开启图像上下文
        UIGraphicsBeginImageContext(CGSize(width: width, height: height))
        /// 获取当前上下文
        if let content = UIGraphicsGetCurrentContext() {
            // 将上下文渲染到当前视图上
            view.layer.render(in: content)
        }
        /// 获取图像上下文的当前图像
        let image = UIGraphicsGetImageFromCurrentImageContext()
        /// 关闭图像上下文
        UIGraphicsEndImageContext()
        /// 返回 UIImageView
        return UIImageView(image: image)
        
    }
}
