//
//  SLGameViewController.swift
//  SLDouYu
//
//  Created by CHEUNGYuk Hang Raymond on 2016/10/31.
//  Copyright © 2016年 CHEUNGYuk Hang Raymond. All rights reserved.
//

import UIKit

//MARK: - 定义常量
private let kEdgeMargin: CGFloat = 10
private let kItemW: CGFloat = (kScreenW - 2 * kEdgeMargin) / 3
private let kItemH: CGFloat = kItemW * 6 / 5
private let kHeaderViewH: CGFloat = 50

private let kGameViewH: CGFloat = 90

private let kHeaderViewReuseIdentifier = "kHeaderViewReuseIdentifier"
private let kGameViewCellReuseIdentifier = "kGameViewCellReuseIdentifier"

class SLGameViewController: UIViewController {
    
    //MARK: - 懒加载
    fileprivate lazy var gameVM: SLGameViewModel = SLGameViewModel()
    /// collectionView
    fileprivate lazy var collectionView: UICollectionView = {[unowned self] in
       
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: kEdgeMargin, bottom: 0, right: kEdgeMargin)
        //设置头部的大小
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.autoresizingMask = [.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        collectionView.dataSource = self
        //注册cell
        collectionView.register(UINib(nibName: "SLRecommendGameCell", bundle: nil), forCellWithReuseIdentifier: kGameViewCellReuseIdentifier)
        //注册header
        collectionView.register(UINib(nibName: "SLCollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewReuseIdentifier)
        
        return collectionView
    }()
    /// 最上面的topHeaderView(常见标题)
    fileprivate lazy var topHeaderView: SLCollectionHeaderView = {
        let headerView = SLCollectionHeaderView.collectionHeaderView()
        headerView.frame = CGRect(x: 0, y: -(kHeaderViewH + kGameViewH), width: kScreenW, height: kHeaderViewH)
        headerView.iconImageView.image = UIImage(named: "")
        headerView.titleLabel.text = "常见"
        headerView.moreButton.isHidden = true
        
        return headerView
    }()
    /// 常见下面的常见游戏的展示
    fileprivate lazy var gameView: SLRecommendGameView = {
        let gameView = SLRecommendGameView.recommendGameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        
        return gameView
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
extension SLGameViewController {
    
    fileprivate func loadData() {
        //发送网络请求
        gameVM.loadAllGameData {
            //展示全部游戏
            self.collectionView.reloadData()
            
            //展示常见游戏
            self.gameView.groups = Array(self.gameVM.games[0 ..< 10])
        }
    }
}

//MARK: - 设置UI界面
extension SLGameViewController {
    fileprivate func setupUI() {
        
        //添加collectionView
        view.addSubview(collectionView)
        
        //添加topHeaderView和gameView
        collectionView.addSubview(topHeaderView)
        collectionView.addSubview(gameView)
        
        //给collectionView设置内边距
        collectionView.contentInset = UIEdgeInsets(top: kHeaderViewH + kGameViewH, left: 0, bottom: 0, right: 0)
    }
}

extension SLGameViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return gameVM.games.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //获取cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameViewCellReuseIdentifier, for: indexPath) as! SLRecommendGameCell
        
        //取出模型
        let game = gameVM.games[indexPath.item]
        
        //给cell赋值
        cell.base = game
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        //获取headerView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewReuseIdentifier, for: indexPath) as! SLCollectionHeaderView
        
        //标题
        headerView.titleLabel.text = "全部"
        //隐藏更多按钮
        headerView.moreButton.isHidden = true
        //设置图片
        headerView.iconImageView.image = UIImage(named: "Img_orange")
        
        return headerView
    }
}
