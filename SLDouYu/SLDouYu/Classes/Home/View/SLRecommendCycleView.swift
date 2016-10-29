//
//  SLRecommendCycleView.swift
//  SLDouYu
//
//  Created by CHEUNGYuk Hang Raymond on 2016/10/28.
//  Copyright © 2016年 CHEUNGYuk Hang Raymond. All rights reserved.
//

import UIKit

//MARK: - 定义常量
private let kCycleCellReuseIdentifier = "kCycleCellReuseIdentifier"

class SLRecommendCycleView: UIView {
    
    //MARK: - 定义属性
    var cycleModels: [SLCycleModel]? {
        didSet {
            guard let cycleModels = cycleModels else { return }
            //刷新列表
            collectionView.reloadData()
            
            //pageControl
            pageControl.numberOfPages = cycleModels.count
        }
    }

    //MARK: - 控件属性
    /// collectionView控件
    @IBOutlet weak var collectionView: UICollectionView!
    /// pageControl控件
    @IBOutlet weak var pageControl: UIPageControl!
    
    //MARK: - 系统回调函数
    override func awakeFromNib() {
        
        //清空autoresizingMask,防止其随父控件的拉升而拉升
        autoresizingMask = UIViewAutoresizing()
    }
    
    //MARK: - 设置layout和collectionView的属性
    //设置collectionView的尺寸(如果直接在awakeFromNib里面设置尺寸,因为从xib中加载的尺寸会不准)
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //获取layout
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        //设置参数
        layout.itemSize = collectionView.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        //设置collectionView的属性
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.showsHorizontalScrollIndicator = false
        
        //注册cell
        collectionView.register(UINib(nibName: "SLRecommendCycleCell", bundle: nil), forCellWithReuseIdentifier: kCycleCellReuseIdentifier)
    }

}

//MARK: - 创建一个加载Xib的类方法
extension SLRecommendCycleView {
    
    class func recommendCycleView() -> SLRecommendCycleView {
        
        return Bundle.main.loadNibNamed("SLRecommendCycleView", owner: nil, options: nil)?.last as! SLRecommendCycleView
    }
}

//MARK: - UICollectionViewDataSource
extension SLRecommendCycleView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return cycleModels?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //获取cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCycleCellReuseIdentifier, for: indexPath) as! SLRecommendCycleCell
        
        //获取模型数据
        let cycleModel = cycleModels![indexPath.item]
        
        //给cell赋值
        cell.cycleModel = cycleModel
        
        cell.backgroundColor = indexPath.item % 2 == 0 ? UIColor.gray : UIColor.green
        
        return cell
    }
}

//MARK: - UICollectionViewDelegate
extension SLRecommendCycleView: UICollectionViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        //获取当前的offsetX,并使其超过一半就造成pageControl的显示更换
        let offsetX = scrollView.contentOffset.x + scrollView.bounds.width * 0.5
        
        //计算当前的pageNum
        let pageNum = Int(offsetX / scrollView.bounds.width)
        
        //更换pageControl的显示
        pageControl.currentPage = pageNum
    }
}
