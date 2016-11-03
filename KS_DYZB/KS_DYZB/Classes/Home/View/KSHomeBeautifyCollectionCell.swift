//
//  KSHomeBeautifyCollectionCell.swift
//  KS_DYZB
//
//  Created by 耳动人王 on 2016/11/3.
//  Copyright © 2016年 KS. All rights reserved.
//

import UIKit

class KSHomeBeautifyCollectionCell: KSHomeBaseCollectionCell {

    // MARK:- 控件属性
    @IBOutlet weak var placeBtn: UIButton!
    override var anchorModel : KSAnchorModel? {
        didSet{
            super.anchorModel = anchorModel
            placeBtn.setTitle(anchorModel?.anchor_city, for: UIControlState())
            
        }
    }

    
   
}
