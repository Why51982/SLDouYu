//
//  SLGameViewModel.swift
//  SLDouYu
//
//  Created by CHEUNGYuk Hang Raymond on 2016/10/31.
//  Copyright © 2016年 CHEUNGYuk Hang Raymond. All rights reserved.
//

import UIKit

class SLGameViewModel {

    //MARK: - 定义属性
    lazy var games: [SLGameModel] = [SLGameModel]()
    
}

extension SLGameViewModel {
    
    //首页-游戏界面发送的数据请求
    //http://capi.douyucdn.cn/api/v1/getColumnDetail?shortName=game
    func loadAllGameData(finishedCallBack: @escaping () -> ()) {
        SLNetworkTools.requestData(SLMethodType.get, URLString: "http://capi.douyucdn.cn/api/v1/getColumnDetail", parameters: ["shortName" : "game"]) { (result) in
            
            //把数据转化成字典
            guard let resultDic = result as? [String : Any] else { return }
            
            //取出data这个key的数组
            guard let dataArray = resultDic["data"] as? [[String : Any]] else { return }
            
            //遍历数组
            for dic in dataArray {
                self.games.append(SLGameModel(dic: dic))
            }
            
            finishedCallBack()
        }
    }
}
