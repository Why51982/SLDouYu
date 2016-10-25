//
//  SLPageContentView.swift
//  SLDouYu
//
//  Created by CHEUNGYuk Hang Raymond on 2016/10/25.
//  Copyright © 2016年 CHEUNGYuk Hang Raymond. All rights reserved.
//

import UIKit

let SLPageContentCellReuseIdentifier = "SLPageContentCellReuseIdentifier"

class SLPageContentView: UIView {

    //MARK: - 定义属性
    fileprivate var childViewControllers: [UIViewController]
    fileprivate weak var parentViewController: UIViewController?
    
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

//MARK: - 对外暴露的方法
extension SLPageContentView {
    
    func setCurrentIndex(_ currentIndex: Int) {
        
        //使collectionView滚动
        let offSetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offSetX, y: 0), animated: false)
        
    }
}
