//
//  UIColor+SLExtension.swift
//  SLDouYu
//
//  Created by CHEUNGYuk Hang Raymond on 2016/10/25.
//  Copyright © 2016年 CHEUNGYuk Hang Raymond. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1.0)
    }
    
    class func randomColor() -> UIColor {
        
        return UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
        
    }
}
