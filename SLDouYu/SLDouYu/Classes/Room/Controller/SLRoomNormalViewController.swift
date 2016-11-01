//
//  SLRoomNormalViewController.swift
//  SLDouYu
//
//  Created by CHEUNGYuk Hang Raymond on 2016/11/1.
//  Copyright © 2016年 CHEUNGYuk Hang Raymond. All rights reserved.
//

import UIKit

class SLRoomNormalViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.green
    }

}

//MARK: - 隐藏/显示navigation
extension SLRoomNormalViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        
        //影藏导航栏
        navigationController?.setNavigationBarHidden(true, animated: true)
//        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        //显示导航栏
//        navigationController?.navigationBar.isHidden = false
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
