//
//  SLBaseModel.swift
//  SLDouYu
//
//  Created by CHEUNGYuk Hang Raymond on 2016/10/31.
//  Copyright © 2016年 CHEUNGYuk Hang Raymond. All rights reserved.
//

import UIKit

class SLBaseModel: NSObject {
    
    //MARK: - 定义属性
    /// 标题
    var tag_name: String = ""
    /// 图标
    var icon_url: String = ""
    
    //MARK: - 自定义构造函数
    init(dic: [String : Any]) {
        super.init()
        
        setValuesForKeys(dic)
    }
    
    override init() {
        
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {    }
}
