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

class SLRecommendViewController: SLBaseAnchorViewController {
    
    //MARK: - 懒加载
    /// 网络请求的VM
    fileprivate lazy var recommendVM: SLRecommendViewModel = SLRecommendViewModel()
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
}

//MARK: - 设置UI界面内容
extension SLRecommendViewController {
    
    //设置UI界面
    override func setupUI() {
        super.setupUI()
        
        //将cycleView添加到collectionView上
        //注意要清空cycle的autoresizingMask,防止其随着父控件的拉升而拉升,造成看不见
        collectionView.addSubview(cycleView)
        
        //添加gameView
        collectionView.addSubview(gameView)
        
        //调整collectionView的内边距,使cycleView显示出来
        collectionView.contentInset = UIEdgeInsets(top: kCycleViewH + kGameViewH, left: 0, bottom: 0, right: 0)
        
    }
}

//MARK: - 请求网络数据
extension SLRecommendViewController {
    
    //请求推荐网络数据
    override func loadData() {
        
        //给父类的ViewModel赋值
        baseVM = recommendVM
        
        //发送轮播的网络请求
        loadCycleData()
        
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
extension SLRecommendViewController: UICollectionViewDelegateFlowLayout {
    
    //UICollectionViewDelegateFlowLayout - 定义item的大小
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //如果为颜值组(第一组),修改尺寸
        if indexPath.section == 1 {
            return CGSize(width: kItemW, height: kPrettyItemH)
        }
        
        return CGSize(width: kItemW, height: kNormalItemH)
    }
}
