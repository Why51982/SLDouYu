//
//  SLRecommendGameCell.swift
//  SLDouYu
//
//  Created by CHEUNGYuk Hang Raymond on 2016/10/30.
//  Copyright © 2016年 CHEUNGYuk Hang Raymond. All rights reserved.
//

import UIKit

class SLRecommendGameCell: UICollectionViewCell {

    //MARK: - 控件属性
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    //MARK: - 定义模型属性
    var base: SLBaseModel? {
        didSet {
            titleLabel.text = base?.tag_name
            
            //设置图标
            let url = URL(string: base?.icon_url ?? "")
            iconImageView.kf.setImage(with: url, placeholder: UIImage(named: "home_more_btn"))
        }
    }
    
}
