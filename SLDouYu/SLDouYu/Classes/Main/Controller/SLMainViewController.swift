//
//  SLMainViewController.swift
//  SLDouYu
//
//  Created by CHEUNGYuk Hang Raymond on 2016/10/24.
//  Copyright © 2016年 CHEUNGYuk Hang Raymond. All rights reserved.
//

import UIKit

class SLMainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //设置子控制器
        setupChildrenController()
    }
}

//MARK: - 设置子控制器
extension SLMainViewController {
    
    fileprivate func setupChildrenController() {
        
        //设置当前选中控制器的tabBar的颜色
        //注意:在iOS7以前,设置了tintColor只有文字会变,图片不会变
        tabBar.tintColor = UIColor.orange
        
        //"首页"控制器
        let home = SLHomeViewController()
        addChildViewController(viewController: home, title: "首页", imageName: "btn_home")
        
        //"直播"控制器
        let live = SLLiveViewController()
        addChildViewController(viewController: live, title: "直播", imageName: "btn_column")
        
        //"关注"控制器
        let follow = SLFollowViewController()
        addChildViewController(viewController: follow, title: "关注", imageName: "btn_live")
        
        //"我的"控制器
        let profile = SLProfileViewController()
        addChildViewController(viewController: profile, title: "我的", imageName: "btn_user")
    }
    
    //添加子控制器的方法
    private func addChildViewController(viewController: UIViewController, title: String, imageName: String) {
    
        //创建导航控制器
        let navigation = SLNavigationController(rootViewController: viewController)
        //设置tabBar的标题
        viewController.tabBarItem.title = title
        
        //设置tabBar上的字体大小
        let textAttribute: [String : Any] = [NSFontAttributeName : UIFont.systemFont(ofSize: 12)]
        viewController.tabBarItem.setTitleTextAttributes(textAttribute, for: UIControlState.normal)
        
        //设置image
        viewController.tabBarItem.image = UIImage(named: imageName + "_normal")
        viewController.tabBarItem.selectedImage = UIImage(named: imageName + "_selected")
        //添加子控制器
        addChildViewController(navigation)
    }
}
