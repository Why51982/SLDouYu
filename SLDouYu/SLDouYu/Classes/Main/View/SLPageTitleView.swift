//
//  SLPageTitleView.swift
//  SLDouYu
//
//  Created by CHEUNGYuk Hang Raymond on 2016/10/24.
//  Copyright © 2016年 CHEUNGYuk Hang Raymond. All rights reserved.
//

import UIKit


//MARK: - 定义代理
protocol SLPageTitleViewDelegate: class {
    
    func pageTitleView(_ pageTitleView: SLPageTitleView, selectedIndex index: Int)
}

//MARK: - 定义常量
private let kScrollLineH: CGFloat = 2
private let kNormalColor: (CGFloat, CGFloat, CGFloat) = (85, 85, 85)
private let kSelectedColor: (CGFloat, CGFloat, CGFloat) = (255, 128, 0)

class SLPageTitleView: UIView {
    
    //MARK: - 定义属性
    fileprivate var titles: [String]
    fileprivate var currentIndex: Int = 0
    weak var delegate: SLPageTitleViewDelegate?
    
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
            
            //给Label添加手势
            label.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.labelDidTap(tapGesture:)))
            label.addGestureRecognizer(tap)
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

//MARK: - Label的手势点击事件
extension SLPageTitleView {
    
    @objc fileprivate func labelDidTap(tapGesture: UITapGestureRecognizer) {
        
        //获取当前点击的Label
        guard let currentLabel = tapGesture.view as? UILabel else { return }
        
        //获取以前的Label
        let oldLabel = titleLabels[currentIndex]
        
        //保存最新Label的下标值
        currentIndex = currentLabel.tag
        
        //切换文字的颜色
        currentLabel.textColor = UIColor.orange
        oldLabel.textColor = UIColor.darkGray
        
        //移动底部显示条
        let scrollLineX = CGFloat(currentIndex) * currentLabel.bounds.width
        UIView.animate(withDuration: 0.2) { 
            self.scrollLine.frame.origin.x = scrollLineX
        }
        
        //通知代理
        delegate?.pageTitleView(self, selectedIndex: currentIndex)
    }
}

//MARK: - 暴露在外部的方法
extension SLPageTitleView {
    func changeTitleIndicator(_ progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        
        //1.取出sourceLabel和targentLabel
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        
        //2.处理标题下面划线的滑动
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = moveTotalX * progress
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        
        //3.颜色渐变
        //3.1取出颜色变化的范围
        let colorDelta = (kSelectedColor.0 - kNormalColor.0, kSelectedColor.1 - kNormalColor.1, kSelectedColor.2 - kNormalColor.2)
        
        //3.2变化sourceLabel的颜色
        sourceLabel.textColor = UIColor(r: kSelectedColor.0 - colorDelta.0 * progress, g: kSelectedColor.1 - colorDelta.1 * progress, b: kSelectedColor.2 - colorDelta.2 * progress)
        
        //3.3变化targetLabel的颜色
        targetLabel.textColor = UIColor(r: kNormalColor.0 + colorDelta.0 * progress, g: kNormalColor.1 + colorDelta.1 * progress, b: kNormalColor.2 + colorDelta.2 * progress)
        
        currentIndex = targetIndex
    }
}
