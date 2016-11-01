//
//  SLNavigationViewController.swift
//  SLDouYu
//
//  Created by CHEUNGYuk Hang Raymond on 2016/11/1.
//  Copyright © 2016年 CHEUNGYuk Hang Raymond. All rights reserved.
//

import UIKit

class SLNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        interactivePopGestureRecognizer?.delegate = nil
    }
}

//MARK: - 拦截push操作
extension SLNavigationController {
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        
        viewController.hidesBottomBarWhenPushed = true
        
        super.pushViewController(viewController, animated: animated)
    }
}
