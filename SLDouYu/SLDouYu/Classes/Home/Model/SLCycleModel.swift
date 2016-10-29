//
//  SLCycleModel.swift
//  SLDouYu
//
//  Created by CHEUNGYuk Hang Raymond on 2016/10/28.
//  Copyright © 2016年 CHEUNGYuk Hang Raymond. All rights reserved.
//

import UIKit

class SLCycleModel: NSObject {

    /// 标题
    var title: String = ""
    /// 展示图片的地址
    var pic_url: String = ""
    /// 主播信息对应的字典
    var room: [String : Any]? {
        didSet {
            
            guard let room = room else { return }
            anchor = SLAnchor(dic: room)
        }
    }
    /// 主播信息对应的模型
    var anchor: SLAnchor?
    
    //MARK: - 自定义构造函数
    init(dic: [String : Any]) {
        super.init()
        
        setValuesForKeys(dic)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) { return  }
}
