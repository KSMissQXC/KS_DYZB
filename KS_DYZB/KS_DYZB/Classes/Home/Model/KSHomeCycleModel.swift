//
//  KSHomeCycleModel.swift
//  KS_DYZB
//
//  Created by 耳动人王 on 2016/11/3.
//  Copyright © 2016年 KS. All rights reserved.
//

import UIKit

class KSHomeCycleModel: NSObject {
    
    // 标题
    var title : String = ""
    // 展示的图片地址
    var pic_url : String = ""
    // 主播信息对应的字典
    var room : [String : NSObject]? {
        didSet {
            guard let room = room else  { return }
            anchor = KSAnchorModel(dict: room)
        }
    }
    // 主播信息对应的模型对象
    var anchor : KSAnchorModel?
    
    // MARK:- 自定义构造函数
    init(dict : [String : NSObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}


}
