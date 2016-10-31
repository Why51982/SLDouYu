//
//  SLCollectionHeaderView.swift
//  SLDouYu
//
//  Created by CHEUNGYuk Hang Raymond on 2016/10/26.
//  Copyright © 2016年 CHEUNGYuk Hang Raymond. All rights reserved.
//

import UIKit

class SLCollectionHeaderView: UICollectionReusableView {

    //MARK: - 控件属性
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var moreButton: UIButton!
    
    //MARK: - 定义属性
    var group: SLAnchorGroup? {
        didSet {
            iconImageView.image = UIImage(named: group?.icon_name ?? "home_header_normal")
            titleLabel.text = group?.tag_name
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        autoresizingMask = UIViewAutoresizing()
    }
}

//MARK: - 创建一个快速创建方法
extension SLCollectionHeaderView {
    
    class func collectionHeaderView() -> SLCollectionHeaderView {
        return Bundle.main.loadNibNamed("SLCollectionHeaderView", owner: nil, options: nil)?.last as! SLCollectionHeaderView
    }
}
