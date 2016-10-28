//
//  SLRecommendViewController.swift
//  SLDouYu
//
//  Created by CHEUNGYuk Hang Raymond on 2016/10/26.
//  Copyright © 2016年 CHEUNGYuk Hang Raymond. All rights reserved.
//

import UIKit

//MARK: - 定义常量
private let kItemMargin: CGFloat = 10
private let kItemW: CGFloat = (kScreenW - 3 * kItemMargin) / 2
private let kNormalItemH: CGFloat = kItemW * 3 / 4
private let kPrettyItemH: CGFloat = kItemW * 4 / 3
private let kHeaderViewH: CGFloat = 50

private let kNormalCellReuseIdentifier = "kNormalCellReuseIdentifier"
private let kPrettyCellReuseIdentifier = "kPrettyCellReuseIdentifier"
private let kHeaderViewReuseIdentifier = "kHeaderViewReuseIdentifier"

class SLRecommendViewController: UIViewController {
    
    //MARK: - 懒加载
    /// 网络请求的VM
    fileprivate lazy var recommendVM: SLRecommendViewModel = SLRecommendViewModel()
    /// 创建collectionView
    fileprivate lazy var collectionView: UICollectionView = {[weak self] in
       
        //创建布局
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 10
        //设置头部
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        
        //创建UICollectionView
        let collectionView: UICollectionView = UICollectionView(frame: self!.view.bounds, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        //让collectionView随着父控件的宽高拉升
        collectionView.autoresizingMask = [UIViewAutoresizing.flexibleHeight, UIViewAutoresizing.flexibleWidth]
        
        //注册cell
        collectionView.register(UINib(nibName: "SLCollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellReuseIdentifier)
        collectionView.register(UINib(nibName: "SLCollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellReuseIdentifier)
        //注册headerView
        collectionView.register(UINib(nibName: "SLCollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewReuseIdentifier)
        
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置UI界面
        setupUI()
        
    }
}

//MARK: - 设置UI界面内容
extension SLRecommendViewController {
    
    //设置UI
    fileprivate func setupUI() {
        
        //添加collectionView
        view.addSubview(collectionView)
        
        //发送网络请求
        loadData()
    }
}

//MARK: - 请求网络数据
extension SLRecommendViewController {
    
    //请求网络数据
    fileprivate func loadData() {
        
        recommendVM.requestData { 
            self.collectionView.reloadData()
        }
    }
}

//MARK: - UICollectionViewDataSource
extension SLRecommendViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return recommendVM.anchorGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return recommendVM.anchorGroups[section].anchors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //取出模型数据
        let anchor = recommendVM.anchorGroups[indexPath.section].anchors[indexPath.item]
        
        //定义cell
        var cell: SLCollectionBaseCell!
        
        if indexPath.section == 1 {
            
            //获取cell
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellReuseIdentifier, for: indexPath) as! SLCollectionPrettyCell
            
            //给模型赋值
            cell.anchor = anchor
        } else {
            
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellReuseIdentifier, for: indexPath) as! SLCollectionNormalCell
            
            cell.anchor = anchor
        }
        return cell
    }
    
    //定义headerView
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        //获取headerView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewReuseIdentifier, for: indexPath) as! SLCollectionHeaderView
        
        //取出模型
        let group = recommendVM.anchorGroups[indexPath.section]
        
        //给headerView赋值
        headerView.group = group
        
        return headerView
    }
    
    //UICollectionViewDelegateFlowLayout - 定义item的大小
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //如果为颜值组(第一组),修改尺寸
        if indexPath.section == 1 {
            return CGSize(width: kItemW, height: kPrettyItemH)
        }
        
        return CGSize(width: kItemW, height: kNormalItemH)
    }
}
