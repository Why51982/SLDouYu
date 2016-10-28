//
//  Date+SLExtension.swift
//  SLDouYu
//
//  Created by CHEUNGYuk Hang Raymond on 2016/10/27.
//  Copyright © 2016年 CHEUNGYuk Hang Raymond. All rights reserved.
//

import Foundation

extension Date {
    //获取当前时间的秒数
    static func getCurrentTime() -> String {
        //获取当前时间
        let nowDate = Date()
        //计算当前时间的秒数
        let interval = Int(nowDate.timeIntervalSince1970)
        
        
        return "\(interval)"
    }
}
