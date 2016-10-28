//
//  SLCollectionPrettyCell.swift
//  SLDouYu
//
//  Created by CHEUNGYuk Hang Raymond on 2016/10/26.
//  Copyright © 2016年 CHEUNGYuk Hang Raymond. All rights reserved.
//

import UIKit

class SLCollectionPrettyCell: UICollectionViewCell {

    //MARK: - 控件属性
    @IBOutlet weak var nickNameLabel: UILabel!
    
    @IBOutlet weak var pictureImageView: UIImageView!
    
    @IBOutlet weak var onlineLabel: UIButton!
    
    @IBOutlet weak var cityLabel: UIButton!
    
    //MARK: - 定义模型属性
    var anchor: SLAnchor? {
        didSet {
            nickNameLabel.text = anchor?.nickname
            
            guard let urlStr = anchor?.vertical_src else { return }
            let url = URL(string: urlStr)
            pictureImageView.kf.setImage(with: url)
            
            var onlineStr: String = ""
            guard let online = anchor?.online else { return }
            if online >= 10000 {
                onlineStr = String(format: "%.1f", CGFloat(online) / 10000.0) + "万人在线"
            } else {
                onlineStr = "\(online)人在线"
            }
            onlineLabel.setTitle(onlineStr, for: .normal)
            
            cityLabel.setTitle(anchor?.anchor_city, for: .normal)
        }
    }
    
}
