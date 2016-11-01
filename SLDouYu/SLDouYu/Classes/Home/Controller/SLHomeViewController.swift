//
//  SLHomeViewController.swift
//  SLDouYu
//
//  Created by CHEUNGYuk Hang Raymond on 2016/10/24.
//  Copyright © 2016年 CHEUNGYuk Hang Raymond. All rights reserved.
//

import UIKit

private let kTitleViewH: CGFloat = 40

class SLHomeViewController: UIViewController {
    
    //MARK: - 懒加载
    fileprivate lazy var pageTitleView: SLPageTitleView = {[weak self] in
       
        let titles: [String] = ["推荐", "游戏", "娱乐", "趣玩"]
        let frame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH, width: kScreenW, height: kTitleViewH)
        let pageTitleView = SLPageTitleView(frame: frame, titles: titles)
        pageTitleView.delegate = self
        
        return pageTitleView
    }()
    
    fileprivate lazy var pageContentView: SLPageContentView = {[weak self] in
        //设置frame
        let height = kScreenH - kStatusBarH - kNavigationBarH - kTitleViewH - kTabBarH
        let contentFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH + kTitleViewH, width: kScreenW, height: height)
        
        //确定所有子控制器
        var childViewControllers = [UIViewController]()
        childViewControllers.append(SLRecommendViewController())
        childViewControllers.append(SLGameViewController())
        childViewControllers.append(SLAmuseViewController())
        childViewControllers.append(SLFunnyViewController())
        
        let pageContentView = SLPageContentView(frame: contentFrame, childViewControllers: childViewControllers, parentViewController: self)
        pageContentView.delegate = self
        
        return pageContentView
    }()

    //MARK: - 系统回调函数
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
        
        //设置view的背景颜色
        view.backgroundColor = UIColor.white
        
        //不需要调整UIScrollView的内边距
        automaticallyAdjustsScrollViewInsets = false
        
        //设置导航栏
        setupNavigationBar()
        
        //添加titleView
        view.addSubview(pageTitleView)
        
        //添加pageContentView
        view.addSubview(pageContentView)
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

//MARK: - SLpageTitleViewDelegate
extension SLHomeViewController: SLPageTitleViewDelegate {
    
    func pageTitleView(_ pageTitleView: SLPageTitleView, selectedIndex index: Int) {
        
        pageContentView.setCurrentIndex(index)
    }
}

//MARK: - SLPageContentViewDelegate
extension SLHomeViewController: SLPageContentViewDelegate {
    func pageContentViewDidScroll(_ pageContentView: SLPageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.changeTitleIndicator(progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}
