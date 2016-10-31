//
//  SLRecommendGameView.swift
//  SLDouYu
//
//  Created by CHEUNGYuk Hang Raymond on 2016/10/29.
//  Copyright © 2016年 CHEUNGYuk Hang Raymond. All rights reserved.
//

import UIKit

//MARK: - 定义常量
private let kGameCellReuseIdentifier = "kGameCellReuseIdentifier"
private let kCollectionViewEdgesMargin: CGFloat = 10

class SLRecommendGameView: UIView {
    
    //MARK: - 定义模型属性
    var groups: [SLBaseModel]? {
        didSet {
            
            //刷新collectionView
            collectionView.reloadData()
        }
    }

    //MARK: - 控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - 系统回调
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //清空autoresizingMask
        autoresizingMask = UIViewAutoresizing()
        
        //注册cell
        collectionView.register(UINib(nibName: "SLRecommendGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellReuseIdentifier)
        
        //设置collectionView的内边距
        collectionView.contentInset = UIEdgeInsets(top: 0, left: kCollectionViewEdgesMargin, bottom: 0, right: 0)
    }
}

//MARK: - 提供一个快速创建的方法
extension SLRecommendGameView {
    
    class func recommendGameView() -> SLRecommendGameView{
        return Bundle.main.loadNibNamed("SLRecommendGameView", owner: nil, options: nil)?.last as! SLRecommendGameView
    }
}

//MARK: - UICollectionViewDataSource
extension SLRecommendGameView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return groups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //获得cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellReuseIdentifier, for: indexPath) as! SLRecommendGameCell
        
        //给cell赋值
        cell.base = groups![indexPath.item]
        
        return cell        
    }
}
