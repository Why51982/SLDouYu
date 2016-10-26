//
//  SLPageContentView.swift
//  SLDouYu
//
//  Created by CHEUNGYuk Hang Raymond on 2016/10/25.
//  Copyright © 2016年 CHEUNGYuk Hang Raymond. All rights reserved.
//

import UIKit

//MARK: - 定义SLPageContentView的代理
protocol SLPageContentViewDelegate: class {
    func pageContentViewDidScroll(_ pageContentView: SLPageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int)
}

//MARK: - 定义全局常量
let SLPageContentCellReuseIdentifier = "SLPageContentCellReuseIdentifier"

//MARK: - SLPageContentView类
class SLPageContentView: UIView {

    //MARK: - 定义属性
    fileprivate var childViewControllers: [UIViewController]
    fileprivate weak var parentViewController: UIViewController?
    fileprivate var startOffsetX: CGFloat = 0
    fileprivate var isForbidScrollDelegate: Bool = false
    weak var delegate: SLPageContentViewDelegate?
    
    //MARK: - 懒加载
    fileprivate lazy var collectionView: UICollectionView = {[weak self] in
        //创建layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = UICollectionViewScrollDirection.horizontal
        
        //创建UICollectionView
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: SLPageContentCellReuseIdentifier)
        
        return collectionView
    }()
    
    //MARK: - 自定义构造函数
    init(frame: CGRect, childViewControllers: [UIViewController], parentViewController: UIViewController?) {
        self.childViewControllers = childViewControllers
        self.parentViewController = parentViewController
        
        super.init(frame: frame)
        
        //设置UI界面
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - 设置UI界面
extension SLPageContentView {
    
    fileprivate func setupUI() {
        //将所有子控制器添加到父控制器中
        for childViewController in childViewControllers {
            parentViewController?.addChildViewController(childViewController)
        }
        
        //添加UICollectionView
        addSubview(collectionView)
        collectionView.frame = bounds
    }
}

//MARK: - UICollectionViewDataSource
extension SLPageContentView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childViewControllers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //创建cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SLPageContentCellReuseIdentifier, for: indexPath)
        
        //给cell设置内容
        let childViewController = childViewControllers[indexPath.item]
        childViewController.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childViewController.view)
        
        return cell
    }
}

//MARK: - UICollectionViewDelegate
extension SLPageContentView: UICollectionViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        //记录需要进行代理方法
        isForbidScrollDelegate = false
        
        //记录开始拖动是的contentOffset
        startOffsetX = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        //如果是点击造成的scrollView的滚动,那么就禁止此方法运行
        if isForbidScrollDelegate {   return   }
        
        //定义需要的数据
        var progress: CGFloat = 0
        var sourceIndex: Int = 0
        var targetIndex: Int = 0
        
        //判断是左滑还是右滑
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.frame.width
        if currentOffsetX > startOffsetX { //左滑
            //计算progress
            progress = currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW)
            
            //计算sourceIndex
            sourceIndex = Int(currentOffsetX / scrollViewW)
            
            //计算targetIndex
            targetIndex = Int(currentOffsetX / scrollViewW) + 1
            
            //左滑完毕的时候(完全滑过去)
            if currentOffsetX - startOffsetX == scrollViewW {
                progress = 1.0
                targetIndex = sourceIndex
            }
        } else {
            //计算progress
            progress = 1 - (currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW))
            
            //计算sourceIndex
            sourceIndex = Int(currentOffsetX / scrollViewW) + 1
            //解决小浮动右滑,返回原currentOffsetX的时候,sourceIndex会+1,造成越界
            if sourceIndex >= childViewControllers.count {
                sourceIndex = childViewControllers.count - 1
            }
            
            //计算targetIndex
            targetIndex = Int(currentOffsetX / scrollViewW)
        }
        
        print("progress: \(progress), source: \(sourceIndex), target: \(targetIndex)")
        //通知代理
        delegate?.pageContentViewDidScroll(self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}

//MARK: - 对外暴露的方法
extension SLPageContentView {
    
    func setCurrentIndex(_ currentIndex: Int) {
        
        //记录不需要进行代理方法
        isForbidScrollDelegate = true
        
        //使collectionView滚动
        let offSetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offSetX, y: 0), animated: false)
        
    }
}
