//
//  SLBaseViewController.swift
//  SLDouYu
//
//  Created by CHEUNGYuk Hang Raymond on 2016/11/1.
//  Copyright © 2016年 CHEUNGYuk Hang Raymond. All rights reserved.
//

import UIKit

class SLBaseViewController: UIViewController {
    
    //MARK: - 定义属性
    var contentView: UIView?

    //MARK: - 懒加载
    fileprivate lazy var animationImageView: UIImageView = {[unowned self] in
       
        let animationImageView = UIImageView(image: UIImage(named: "img_loading_1"))
        animationImageView.center = self.view.center
        animationImageView.animationImages = [UIImage(named: "img_loading_1")!, UIImage(named: "img_loading_2")!]
        animationImageView.animationDuration = 0.5
        animationImageView.animationRepeatCount = LONG_MAX
        animationImageView.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin]
        
        return animationImageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //设置UI界面
        setupUI()
    }
}

//MARK: - 设置UI界面
extension SLBaseViewController {
    
    func setupUI() {
        
        //隐藏内容
        contentView?.isHidden = true
        
        //添加animation
        view.addSubview(animationImageView)
        
        //开始动画
        animationImageView.startAnimating()
        
        //设置view的背景颜色
        view.backgroundColor = UIColor(r: 250, g: 250, b: 250)
    }
    
    //当加载数据完毕时就停止动画,并显示collectionView
    func loadDataFinished() {
        
        //停止动画
        animationImageView.stopAnimating()
        
        //隐藏animationImageView
        animationImageView.isHidden = true
        
        //显示contentView
        contentView?.isHidden = false
    }
}
