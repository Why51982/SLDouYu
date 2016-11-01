//
//  SLBaseAnchorViewController.swift
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

private let kNormalCellReuseIdentifier = "kNormalCellReuseIdentifier"
private let kPrettyCellReuseIdentifier = "kPrettyCellReuseIdentifier"
private let kHeaderViewReuseIdentifier = "kHeaderViewReuseIdentifier"

class SLBaseAnchorViewController: SLBaseViewController {

    //MARK: - 懒加载
    var baseVM: SLBaseViewModel!
    /// 创建collectionView
    lazy var collectionView: UICollectionView = {[weak self] in
        
        //创建布局
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 10
        layout.itemSize = CGSize(width: kItemW, height: kNormalItemH)
        //设置头部的size
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        
        //创建UICollectionView
        let collectionView: UICollectionView = UICollectionView(frame: self!.view.bounds, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        //让collectionView随着父控件的宽高拉升
        collectionView.autoresizingMask = [UIViewAutoresizing.flexibleHeight, UIViewAutoresizing.flexibleWidth]
        
        //注册cell
        collectionView.register(UINib(nibName: "SLCollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellReuseIdentifier)
        collectionView.register(UINib(nibName: "SLCollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellReuseIdentifier)
        //注册headerView
        collectionView.register(UINib(nibName: "SLCollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewReuseIdentifier)
        
        return collectionView
        }()
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置UI界面
        setupUI()
        
        //发送网络请求
        loadData()
    }
}

//MARK: - 发送网络请求
extension SLBaseAnchorViewController {
    
    func loadData() {
        
    }
}

//MARK: - 设置UI界面
extension SLBaseAnchorViewController {
    
    override func setupUI() {
        
        //给父控件的contentView赋值
        contentView = collectionView
        
        //添加collectionView
        view.addSubview(collectionView)
        
        super.setupUI()
    }
}

extension SLBaseAnchorViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return baseVM.anchorGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return baseVM.anchorGroups[section].anchors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //获取cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellReuseIdentifier, for: indexPath) as! SLCollectionNormalCell
        
        //取出模型
        let amuseModel = baseVM.anchorGroups[indexPath.section].anchors[indexPath.item]
        
        cell.anchor = amuseModel
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewReuseIdentifier, for: indexPath) as! SLCollectionHeaderView
        
        let group = baseVM.anchorGroups[indexPath.section]
        group.icon_name = "home_header_normal"
        headerView.group = group
        
        return headerView
    }
}

