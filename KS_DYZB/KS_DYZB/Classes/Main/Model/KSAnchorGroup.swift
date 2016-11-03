//
//  KSAnchorGroup.swift
//  KS_DYZB
//
//  Created by 耳动人王 on 2016/11/2.
//  Copyright © 2016年 KS. All rights reserved.
//

import UIKit

class KSAnchorGroup: NSObject {
    
    // MARK:- 定义属性
    var tag_name : String = ""
    var icon_url : String = ""
    
    /// 组显示的图标
    var icon_name : String = "home_header_normal"
    /// 定义主播的模型对象数组
    lazy var anchors : [KSAnchorModel] = [KSAnchorModel]()
    
    /// 该组中对应的房间信息
    var room_list : [[String : NSObject]]? {
        didSet{
            guard let room_list = room_list else {
                return
            }
            
            for dict in room_list {
                anchors.append(KSAnchorModel(dict: dict))
            }
            
            
        }
    }
    
    // MARK:- 自定义构造函数
    override init() {
        
    }

    
    init(dict : [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    


}
