//
//  UIColor_KSExtension.swift
//  KS_DYZB
//
//  Created by 耳动人王 on 2016/10/31.
//  Copyright © 2016年 KS. All rights reserved.
//

import UIKit

extension UIColor{
    
    convenience init(r : CGFloat,g : CGFloat,b : CGFloat) {
        
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1.0)
    }
    
    class func randomColor() -> UIColor{
            return UIColor(r: CGFloat(arc4random_uniform(256)), g: CGFloat(arc4random_uniform(256)), b: CGFloat(arc4random_uniform(256)))
    }
    
    
    
}
