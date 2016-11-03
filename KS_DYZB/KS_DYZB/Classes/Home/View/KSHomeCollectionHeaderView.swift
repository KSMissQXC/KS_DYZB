//
//  KSHomeCollectionHeaderView.swift
//  KS_DYZB
//
//  Created by 耳动人王 on 2016/11/2.
//  Copyright © 2016年 KS. All rights reserved.
//

import UIKit

class KSHomeCollectionHeaderView: UICollectionReusableView {
    // MARK:- 控件属性
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var moreBtn: UIButton!
    
    var group : KSAnchorGroup?{
        didSet{
            titleLabel.text = group?.tag_name
            iconImageView.image = UIImage(named: group?.icon_name ?? "home_header_normal")
        }
    }
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
