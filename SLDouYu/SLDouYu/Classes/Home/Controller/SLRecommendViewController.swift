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

private let kCycleViewH: CGFloat = kScreenW * 3 / 8
private let kGameViewH: CGFloat = 90

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
        //设置头部的size
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
    /// 创建cycleView
    fileprivate lazy var cycleView: SLRecommendCycleView = {
       
        let cycleView = SLRecommendCycleView.recommendCycleView()
        cycleView.frame = CGRect(x: 0, y: -(kCycleViewH + kGameViewH), width: kScreenW, height: kCycleViewH)
        return cycleView
    }()
    /// 创建推荐游戏界面
    fileprivate lazy var gameView: SLRecommendGameView = {
       
        let gameView = SLRecommendGameView.recommendGameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        return gameView
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
        
        //将cycleView添加到collectionView上
        //注意要清空cycle的autoresizingMask,防止其随着父控件的拉升而拉升,造成看不见
        collectionView.addSubview(cycleView)
        
        //添加gameView
        collectionView.addSubview(gameView)
        
        //调整collectionView的内边距,使cycleView显示出来
        collectionView.contentInset = UIEdgeInsets(top: kCycleViewH + kGameViewH, left: 0, bottom: 0, right: 0)
        
        //发送推荐网络请求
        loadData()
        
        //发送轮播的网络请求
        loadCycleData()
    }
}

//MARK: - 请求网络数据
extension SLRecommendViewController {
    
    //请求推荐网络数据
    fileprivate func loadData() {
        
        recommendVM.requestData {
            //刷新表格
            self.collectionView.reloadData()
            
            //取出数据
            var groups = self.recommendVM.anchorGroups
            
            //去除前两组数据
            groups.remove(at: 0)
            groups.remove(at: 0)
            
            //拼接更多一组
            let moreGroup = SLAnchorGroup()
            moreGroup.tag_name = "更多"
            groups.append(moreGroup)
            
            //给GameView赋值
            self.gameView.groups = groups
        }
    }
    
    //请求轮播图的网络数据
    fileprivate func loadCycleData() {
        recommendVM.requestCycleData { 
            self.cycleView.cycleModels = self.recommendVM.cycleModels
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
