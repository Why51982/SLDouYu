//
//  SLAmuseMenuViewCell.swift
//  SLDouYu
//
//  Created by CHEUNGYuk Hang Raymond on 2016/11/1.
//  Copyright © 2016年 CHEUNGYuk Hang Raymond. All rights reserved.
//

import UIKit

private let kAmuseMenuCellID = "kAmuseMenuCellID"

class SLAmuseMenuViewCell: UICollectionViewCell {
    
    //MARK: - 定义属性
    var groups: [SLAnchorGroup]? {
        didSet {
            //刷新表格
            collectionView.reloadData()
        }
    }

    //MARK: - 控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - awakeFromNib
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //注册cell
        collectionView.register(UINib(nibName: "SLRecommendGameCell", bundle: nil), forCellWithReuseIdentifier: kAmuseMenuCellID)
    }
    
    //MARK: - 重新布局layout
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let itemW = collectionView.bounds.width / 4
        let itemH = collectionView.bounds.height / 2
        layout.itemSize = CGSize(width: itemW, height: itemH)
    }
}

extension SLAmuseMenuViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return groups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //获取cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kAmuseMenuCellID, for: indexPath) as! SLRecommendGameCell
        
        cell.base = groups![indexPath.item]
        cell.clipsToBounds = true
        
        return cell
    }
}
