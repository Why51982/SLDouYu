//
//  UIBarButtonItem+SLExtension.swift
//  SLDouYu
//
//  Created by CHEUNGYuk Hang Raymond on 2016/10/24.
//  Copyright © 2016年 CHEUNGYuk Hang Raymond. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    //便利构造函数: 1.convenience开头 2.在构造函数中必须明确调用一个设计的构造函数(self)
    convenience init(imageName: String, highImageName: String = "", size: CGSize = CGSize.zero) {
        //创建UIButton
        let button = UIButton()
        
        //设置图片
        button.setImage(UIImage(named: imageName), for: UIControlState.normal)
        if highImageName != "" {
            button.setImage(UIImage(named: highImageName), for: UIControlState.highlighted)
        }
        
        //设置尺寸
        if size == CGSize.zero {
            button.sizeToFit()
        } else {
            button.frame = CGRect(origin: CGPoint.zero, size: size)
        }
        
        //创建UIBarButtonItem
        self.init(customView: button)
    }
}
