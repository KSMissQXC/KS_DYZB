//
//  KSHomeBaseCollectionCell.swift
//  KS_DYZB
//
//  Created by 耳动人王 on 2016/11/3.
//  Copyright © 2016年 KS. All rights reserved.
//

import UIKit

class KSHomeBaseCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var onlineBtn: UIButton!
    @IBOutlet weak var nickNameLabel: UILabel!
    
    var anchorModel : KSAnchorModel? {
        didSet{
            // 0.校验模型是否有值
            guard let anchor = anchorModel else { return }
            
            // 1.取出在线人数显示的文字
            var onlineStr : String = ""
            if anchor.online >= 10000 {
                onlineStr = "\(Int(anchor.online / 10000))万在线"
            } else {
                onlineStr = "\(anchor.online)在线"
            }
            onlineBtn.setTitle(onlineStr, for: UIControlState())
            
            // 2.昵称的显示
            nickNameLabel.text = anchor.nickname
            
            // 3.设置封面图片
            guard let iconURL = URL(string: anchor.vertical_src) else { return }
            iconImageView.kf.setImage(with: iconURL)
            
            //            // 2.所在的城市
            //            placeBtn.setTitle(anchor.anchor_city, for: UIControlState())
            
            
        }
    }
    

    
    
}
