//
//  SLBaseViewModel.swift
//  SLDouYu
//
//  Created by CHEUNGYuk Hang Raymond on 2016/10/31.
//  Copyright © 2016年 CHEUNGYuk Hang Raymond. All rights reserved.
//

import UIKit

class SLBaseViewModel {

    //MARK: - 定义属性
    lazy var anchorGroups: [SLAnchorGroup] = [SLAnchorGroup]()
}

extension SLBaseViewModel {
    
    func loadAnchorData(urlString: String, parameters: [String : Any]? = nil, finishedCallBack: @escaping () -> ()) {
        
        SLNetworkTools.requestData(.get, URLString: urlString, parameters: parameters) {
            (result) in
            
            //把结果转化成字典
            guard let resultDic = result as? [String : Any] else { return }
            
            //取出data这个key对应的数组
            guard let dataArray = resultDic["data"] as? [[String : Any]] else { return }
            
            //遍历数组
            for dic in dataArray {
                let anchorGroup = SLAnchorGroup(dic: dic)
                if anchorGroup.room_list?.count == 0 {
                    continue
                }
                self.anchorGroups.append(anchorGroup)
            }
            
            finishedCallBack()
        }
    }
    
}
