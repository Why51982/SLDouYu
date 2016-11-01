//
//  SLAmuseViewController.swift
//  SLDouYu
//
//  Created by CHEUNGYuk Hang Raymond on 2016/10/31.
//  Copyright © 2016年 CHEUNGYuk Hang Raymond. All rights reserved.
//

import UIKit

//MARK: - 定义常量
private let kItemMargin: CGFloat = 10
private let kItemW: CGFloat = (kScreenW - 3 * kItemMargin) / 2
private let kNormalItemH: CGFloat = kItemW * 3 / 4
private let kPrettyItemH: CGFloat = kItemW * 4 / 3
private let kHeaderViewH: CGFloat = 50

private let kCycleViewH: CGFloat = kScreenW * 3 / 8
private let kGameViewH: CGFloat = 90
private let kAmuseMenuViewH: CGFloat = 200

private let kNormalCellReuseIdentifier = "kNormalCellReuseIdentifier"
private let kPrettyCellReuseIdentifier = "kPrettyCellReuseIdentifier"
private let kHeaderViewReuseIdentifier = "kHeaderViewReuseIdentifier"

class SLAmuseViewController: SLBaseAnchorViewController {

    //MARK: - 懒加载
    fileprivate lazy var amuseVM: SLAmuseViewModel = SLAmuseViewModel()
    fileprivate lazy var amuseMenuView: SLAmuseMenuView = {
       
        let amuseMenuView = SLAmuseMenuView.amuseMenuView()
        amuseMenuView.frame = CGRect(x: 0, y: -kAmuseMenuViewH, width: kScreenW, height: kAmuseMenuViewH)
        
        return amuseMenuView
    }()
}

//MARK: - 设置UI界面
extension SLAmuseViewController {
    
    override func setupUI() {
        super.setupUI()
        
        //添加amuseView
        collectionView.addSubview(amuseMenuView)
        
        //设置collectionView的内边距
        collectionView.contentInset = UIEdgeInsets(top: kAmuseMenuViewH, left: 0, bottom: 0, right: 0)
    }
}

extension SLAmuseViewController {
    
    //发送网络请求
    override func loadData() {
        
        //给父类的ViewModel赋值
        baseVM = amuseVM
        
        //发送网络请求
        amuseVM.loadAmuseData {
            
            //刷新表格
            self.collectionView.reloadData()
            
            //调整数据
            var tempGroups = self.amuseVM.anchorGroups
            tempGroups.removeFirst()
            self.amuseMenuView.groups = tempGroups
            
            //停止动画，并显示collectionView
            self.loadDataFinished()
        }
    }
}

