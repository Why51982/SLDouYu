//
//  SLPageTitleView.swift
//  SLDouYu
//
//  Created by CHEUNGYuk Hang Raymond on 2016/10/24.
//  Copyright © 2016年 CHEUNGYuk Hang Raymond. All rights reserved.
//

import UIKit

private let kScrollLineH: CGFloat = 2

class SLPageTitleView: UIView {
    
    //MARK: - 定义属性
    fileprivate var titles: [String]
    
    //MARK: - 懒加载
    fileprivate lazy var scrollView: UIScrollView = {
       
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        
        return scrollView
    }()
    
    fileprivate lazy var scrollLine: UIView = {
       
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()
    
    //此属性方便从scrollView中拿到Label
    fileprivate lazy var titleLabels: [UILabel] = [UILabel]()

    //MARK: - 自定义构造方法
    init(frame: CGRect, titles: [String]) {
        self.titles = titles
        
        super.init(frame: frame)
        
        //设置UI界面
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - 设置UI界面
extension SLPageTitleView {
    
    fileprivate func setupUI() {
        
        //设置scrollView
        addSubview(scrollView)
        scrollView.frame = bounds
        
        //添加title对应的Label
        setupTitleLabels()
        
        //设置底部线和滑块
        setupBottomLineAndScrollLine()
    }
    
    //添加title对应的Label
    private func setupTitleLabels() {
        
        //确定Label的一些frame值
        let labelW: CGFloat = frame.width / CGFloat(titles.count)
        let labelH: CGFloat = frame.height - kScrollLineH
        let labelY: CGFloat = 0
        
        for (index, title) in titles.enumerated() {
            //创建Label
            let label = UILabel()
            
            //设置Label的属性
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16)
            label.textColor = UIColor.darkGray
            label.textAlignment = NSTextAlignment.center
            
            //设置Label的frame
            let labelX = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            //将Label添加到scrollView上
            scrollView.addSubview(label)
            titleLabels.append(label)
        }
    }
    
    //设置底部线和滑块
    private func setupBottomLineAndScrollLine() {
        
        //设置底部线
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        let lineH: CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        addSubview(bottomLine)
        
        //添加scrollLine
        //拿到Label(用scrollView的子控件不好拿,因为UIscrollView本身就有子控件)
        guard let firstLabe = titleLabels.first else {   return  }
        firstLabe.textColor = UIColor.orange
        
        //设置scrollLine的属性
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabe.frame.origin.x, y: frame.height - kScrollLineH, width: firstLabe.frame.width, height: kScrollLineH)
    }
}
