//
//  SLAnchorGroup.swift
//  SLDouYu
//
//  Created by CHEUNGYuk Hang Raymond on 2016/10/27.
//  Copyright © 2016年 CHEUNGYuk Hang Raymond. All rights reserved.
//

import UIKit

class SLAnchorGroup: SLBaseModel {

    /// 该组中对应的房间信息
    var room_list: [[String : Any]]? {
        didSet {
            guard let list = room_list else {  return  }
            for an in list {
                let anchor = SLAnchor.init(dic: an)
                anchors.append(anchor)
            }
        }
    }
    /// 组显示的图标
    var icon_name: String = "home_header_hot"
    /// 定义主播的模型对象数组
    lazy var anchors: [SLAnchor] = [SLAnchor]()
    
}
