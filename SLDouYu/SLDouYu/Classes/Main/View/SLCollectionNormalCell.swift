//
//  SLCollectionNormalCell.swift
//  SLDouYu
//
//  Created by CHEUNGYuk Hang Raymond on 2016/10/26.
//  Copyright © 2016年 CHEUNGYuk Hang Raymond. All rights reserved.
//

import UIKit
import Kingfisher

class SLCollectionNormalCell: UICollectionViewCell {

    //MARK: - 控件属性
    /// 封面图片
    @IBOutlet weak var pictureImageView: UIImageView!
    /// 主播昵称
    @IBOutlet weak var nickNameLabel: UILabel!
    /// 在线人数
    @IBOutlet weak var onlineLabel: UIButton!
    /// 主播房间名称
    @IBOutlet weak var titleLabel: UILabel!
    
    //MARK: - 定义模型属性
    var anchor: SLAnchor? {
        didSet {
            //主播房间名称
            titleLabel.text = anchor?.room_name
            
            //主播封面图片
            guard let urlStr = anchor?.vertical_src else { return }
            let url = URL(string: urlStr)
            pictureImageView.kf.setImage(with: url)
            
            //主播昵称
            nickNameLabel.text = anchor?.nickname
            
            //在线人数
            var onlineStr: String = ""
            guard let online = anchor?.online else { return }
            if online >= 10000 {
                onlineStr = String(format: "%.1f", CGFloat(online) / 10000.0) + "万人在线"
            } else {
                onlineStr = "\(online)人在线"
            }
            onlineLabel.setTitle(onlineStr, for: UIControlState.normal)
        }
    }
}
