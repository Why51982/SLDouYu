//
//  SLRecommendCycleCell.swift
//  SLDouYu
//
//  Created by CHEUNGYuk Hang Raymond on 2016/10/29.
//  Copyright © 2016年 CHEUNGYuk Hang Raymond. All rights reserved.
//

import UIKit

class SLRecommendCycleCell: UICollectionViewCell {

    //MARK: - 控件属性
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    //MARK: - 定义模型属性
    var cycleModel: SLCycleModel? {
        didSet {
            guard let cycleModel = cycleModel else { return }
            titleLabel.text = cycleModel.title
            let url = URL(string: cycleModel.pic_url)
            iconImageView.kf.setImage(with: url)
        }
    }

}
