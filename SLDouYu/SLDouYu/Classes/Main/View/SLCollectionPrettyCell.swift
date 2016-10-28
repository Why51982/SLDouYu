//
//  SLCollectionPrettyCell.swift
//  SLDouYu
//
//  Created by CHEUNGYuk Hang Raymond on 2016/10/26.
//  Copyright © 2016年 CHEUNGYuk Hang Raymond. All rights reserved.
//

import UIKit

class SLCollectionPrettyCell: SLCollectionBaseCell {

    
    @IBOutlet weak var cityLabel: UIButton!
    
    //MARK: - 定义模型属性
    override var anchor: SLAnchor? {
        didSet {
            //将属性赋值给父类
            super.anchor =  anchor
            
            //显示城市
            cityLabel.setTitle(anchor?.anchor_city, for: .normal)
        }
    }
    
}
