//
//  YachtCardStore.swift
//  XMCustomUIViewControllerTransitions
//
//  Created by TwtMac on 17/1/22.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class YachtCardStore: NSObject {

    class func defaultBeauties() -> [YachtCard] {
        guard let filePath = Bundle.main.path(forResource: "Yacht", ofType: "plist"),
                let dict = NSDictionary.init(contentsOfFile: filePath) else {
            return []
        }
        
        let yachtsArray = dict["yachts"] as! [[String: AnyObject]]
        
        var array:[YachtCard] = Array()
        
        for dic in yachtsArray {
            let model = YachtCard()
            model.setValuesForKeys(dic)
            array.append(model)
        }
        
        return array
    }
}
