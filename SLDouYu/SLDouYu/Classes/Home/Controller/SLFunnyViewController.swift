//
//  SLFunnyViewController.swift
//  SLDouYu
//
//  Created by CHEUNGYuk Hang Raymond on 2016/11/1.
//  Copyright © 2016年 CHEUNGYuk Hang Raymond. All rights reserved.
//

import UIKit

private let kTopMargin: CGFloat = 8

class SLFunnyViewController: SLBaseAnchorViewController {
    
    //MARK: - 懒加载
    fileprivate lazy var funnyVM: SLFunnyViewModel = SLFunnyViewModel()
    
}

//MARK: - 设置UI界面
extension SLFunnyViewController {
    
    override func setupUI() {
        super.setupUI()
        
        //清除组头
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.headerReferenceSize = CGSize.zero
        collectionView.contentInset = UIEdgeInsets(top: kTopMargin, left: 0, bottom: 0, right: 0)
    }
}

//MARK: - 请求数据
extension SLFunnyViewController {
    
    override func loadData() {
        //给父类模型赋值
        baseVM = funnyVM
        
        //请求数据
        funnyVM.loadFunnyData { 
            self.collectionView.reloadData()
        }
    }
}
