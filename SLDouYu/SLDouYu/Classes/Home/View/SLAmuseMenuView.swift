//
//  SLAmuseMenuView.swift
//  SLDouYu
//
//  Created by CHEUNGYuk Hang Raymond on 2016/11/1.
//  Copyright © 2016年 CHEUNGYuk Hang Raymond. All rights reserved.
//

import UIKit

private let kAmuseMenuCellReuseIdentifier = "kAmuseMenuCellReuseIdentifier"

class SLAmuseMenuView: UIView {

    //MARK: - 定义属性
    var groups: [SLAnchorGroup]? {
        didSet {
            //刷新表格
            collectionView.reloadData()
            
        }
    }
    
    //MARK: - 控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    //MARK: - awakeFromNib
    override func awakeFromNib() {
        super.awakeFromNib()
        
        autoresizingMask = UIViewAutoresizing()
        
        //注册cell
        collectionView.register(UINib(nibName: "SLAmuseMenuViewCell", bundle: nil), forCellWithReuseIdentifier: kAmuseMenuCellReuseIdentifier)
    }
}

//MARK: - 设置collectionView的参数
extension SLAmuseMenuView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
    }
    
}

//MARK: - 定义一个快速创建的方法
extension SLAmuseMenuView {
    
    class func amuseMenuView() -> SLAmuseMenuView {
        
        return Bundle.main.loadNibNamed("SLAmuseMenuView", owner: nil, options: nil)?.first as! SLAmuseMenuView
    }
}

//MARK: - UICollectionViewDataSource
extension SLAmuseMenuView: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if groups == nil {  return 0  }
        
        let num = (groups!.count - 1) / 8 + 1
        pageControl.numberOfPages = num
        return num
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //获取cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kAmuseMenuCellReuseIdentifier, for: indexPath) as! SLAmuseMenuViewCell
        
        //给cell设置数据
        setupCellData(cell: cell, indexPath: indexPath)
        
        return cell
    }
    
    private func setupCellData(cell: SLAmuseMenuViewCell, indexPath: IndexPath) {
        // 1页: 0 ~ 7
        // 2页: 8 ~ 15
        let startIndex = indexPath.item * 8
        var endIndex = (indexPath.item + 1) * 8 - 1
        
        //如果越界
        if endIndex > groups!.count - 1 {
            endIndex = groups!.count - 1
        }
        
        //给cell赋值
        cell.groups = Array(groups![startIndex ... endIndex])
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.bounds.width + 0.5)
    }
}
