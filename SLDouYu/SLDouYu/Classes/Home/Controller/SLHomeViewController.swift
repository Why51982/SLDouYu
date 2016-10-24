//
//  SLHomeViewController.swift
//  SLDouYu
//
//  Created by CHEUNGYuk Hang Raymond on 2016/10/24.
//  Copyright © 2016年 CHEUNGYuk Hang Raymond. All rights reserved.
//

import UIKit

class SLHomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //设置UI界面
        setupUI()
    }

}

//MARK: - 设置UI界面
extension SLHomeViewController {
    
    //设置UI界面
    fileprivate func setupUI() {
        
        //设置导航栏
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        
        //设置导航栏左边的按钮
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "logo"), for: UIControlState.normal)
        button.sizeToFit()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
        
        //设置导航栏右边的按钮
        let size = CGSize(width: 40, height: 40)
        //历史
        let historyItem = UIBarButtonItem(imageName: "image_my_history", highImageName: "Image_my_history_click", size: size)
        //搜索
        let searchItem = UIBarButtonItem(imageName: "btn_search", highImageName: "btn_search_clicked", size: size)
        //二维码
        let qrcodeItem = UIBarButtonItem(imageName: "Image_scan", highImageName: "Image_scan_click", size: size)
        navigationItem.rightBarButtonItems = [historyItem, searchItem, qrcodeItem]
    }
}