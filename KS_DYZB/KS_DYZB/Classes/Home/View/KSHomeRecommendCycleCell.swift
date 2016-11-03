//
//  KSHomeRecommendCycleCell.swift
//  KS_DYZB
//
//  Created by 耳动人王 on 2016/11/3.
//  Copyright © 2016年 KS. All rights reserved.
//

import UIKit
import Kingfisher



class KSHomeRecommendCycleCell: UICollectionViewCell {

    // MARK: 控件属性
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    // MARK: 定义模型属性
    var cycleModel : KSHomeCycleModel? {
        didSet {
            titleLabel.text = cycleModel?.title
            let iconURL = URL(string: cycleModel?.pic_url ?? "")!
            iconImageView.kf.setImage(with: iconURL, placeholder: UIImage(named: "Img_default"))
        }
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
