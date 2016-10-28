//
//  SLCollectionNormalCell.swift
//  SLDouYu
//
//  Created by CHEUNGYuk Hang Raymond on 2016/10/26.
//  Copyright © 2016年 CHEUNGYuk Hang Raymond. All rights reserved.
//

import UIKit
import Kingfisher

class SLCollectionNormalCell: SLCollectionBaseCell {

    /// 主播房间名称
    @IBOutlet weak var titleLabel: UILabel!
    
    //MARK: - 定义模型属性
    override var anchor: SLAnchor? {
        didSet {
            //将属性赋值给父类
            super.anchor = anchor
            
            //主播房间名称
            titleLabel.text = anchor?.room_name
        }
    }
}
