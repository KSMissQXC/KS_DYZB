//
//  KSHomeCollectionViewCell.swift
//  KS_DYZB
//
//  Created by 耳动人王 on 2016/11/2.
//  Copyright © 2016年 KS. All rights reserved.
//

import UIKit
import Kingfisher

class KSHomeCollectionViewCell: KSHomeBaseCollectionCell {
    
    // MARK:- 控件属性

    @IBOutlet weak var roomLabel: UILabel!
    override var anchorModel : KSAnchorModel?{
        didSet{
            super.anchorModel = anchorModel
            self.roomLabel.text = anchorModel?.room_name
        }
        
    }
    
    
}






