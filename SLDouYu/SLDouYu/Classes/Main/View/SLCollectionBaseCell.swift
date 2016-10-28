//
//  SLCollectionBaseCell.swift
//  SLDouYu
//
//  Created by CHEUNGYuk Hang Raymond on 2016/10/28.
//  Copyright © 2016年 CHEUNGYuk Hang Raymond. All rights reserved.
//

import UIKit

class SLCollectionBaseCell: UICollectionViewCell {
    
    //MARK: - 控件属性
    /// 封面图片
    @IBOutlet weak var pictureImageView: UIImageView!
    /// 主播昵称
    @IBOutlet weak var nickNameLabel: UILabel!
    /// 在线人数
    @IBOutlet weak var onlineLabel: UIButton!
    
    //MARK: - 定义模型属性
    var anchor: SLAnchor? {
        didSet {
            //验证模型是否有值
            guard let anchor = anchor else { return }
            
            //主播昵称
            nickNameLabel.text = anchor.nickname
            
            //在线人数
            var onlineStr: String = ""
            if anchor.online >= 10000 {
                onlineStr = String(format: "%.1f", CGFloat(anchor.online) / 10000.0) + "万人在线"
            } else {
                onlineStr = "\(anchor.online)人在线"
            }
            onlineLabel.setTitle(onlineStr, for: UIControlState.normal)
            
            //主播封面图片(避免造成因为没有anchor.vertical_src,造成昵称和在线人数都没有的情况,此句放在最后设置)
            guard let url = URL(string: anchor.vertical_src) else { return }
            pictureImageView.kf.setImage(with: url)
            
            
        }
    }
}
