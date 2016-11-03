//
//  NSDate_KSExtension.swift
//  KS_DYZB
//
//  Created by 耳动人王 on 2016/11/2.
//  Copyright © 2016年 KS. All rights reserved.
//

import Foundation

extension Date{
    static func getCurrentTime() -> String{
        let nowDate = Date()
        let interal = Int(nowDate.timeIntervalSince1970)
        return "\(interal)"
    }
    
}
