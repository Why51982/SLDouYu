
//
//  SLRecommendViewModel.swift
//  SLDouYu
//
//  Created by CHEUNGYuk Hang Raymond on 2016/10/27.
//  Copyright © 2016年 CHEUNGYuk Hang Raymond. All rights reserved.
//

import UIKit

class SLRecommendViewModel {

    //MARK: - 懒加载属性
    lazy var anchorGroups: [SLAnchorGroup] = [SLAnchorGroup]()
    lazy var cycleModels: [SLCycleModel] = [SLCycleModel]()
    fileprivate lazy var bigDataGroup: SLAnchorGroup = SLAnchorGroup()
    fileprivate lazy var prettyGroup: SLAnchorGroup = SLAnchorGroup()
}

//MARK: - 发送网络请求
extension SLRecommendViewModel {
    
    //发送推荐的网络请求
    func requestData(_ finishedCallBack: @escaping () -> ()) {
        //请求参数
        let parameters = ["limit" : "4", "offset" : "0", "time" : Date.getCurrentTime()]
        
        //因为是异步请求，所以必须等到所有的数据全部加载完毕才能添加到最终的数组中
        //创建线程组
        let dGroup = DispatchGroup()
        //请求第一部分热门数据
        //请求发起前,进入组
        dGroup.enter()
        SLNetworkTools.requestData(SLMethodType.get, URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: ["time" : Date.getCurrentTime()]) { (result) in
            
            //将数据转化成字典
            guard let resultDic = result as? [String : Any] else { return }
            
            
            //根据data这个key获取数组
            guard let dataArray = resultDic["data"] as? [[String : Any]] else { return }
            
            self.bigDataGroup.tag_name = "最热"
            self.bigDataGroup.icon_name = "home_header_hot"
            
            for dic in dataArray {
                let anchor = SLAnchor(dic: dic)
                self.bigDataGroup.anchors.append(anchor)
            }
            
            //接收数据完毕离开组
            dGroup.leave()
        }
        
        //请求第二部分颜值数据
        //请求发起前,进入组
        dGroup.enter()
        SLNetworkTools.requestData(SLMethodType.get, URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: parameters) { (result) in
            
            //将数据转化成字典
            guard let resultDic = result as? [String : Any] else { return }
            
            //根据data这个key获取数组
            guard let dataArray = resultDic["data"] as? [[String : Any]] else { return }
            
            self.prettyGroup.tag_name = "颜值"
            self.prettyGroup.icon_name = "home_header_phone"
            
            for dic in dataArray {
                let anchor = SLAnchor(dic: dic)
                self.prettyGroup.anchors.append(anchor)
            }
            
            //接收数据完毕离开组
            dGroup.leave()
        }
        
        //请求后面部分(2 - 12组)游戏数据
        //http://capi.douyucdn.cn/api/v1/getHotCate?limit=4&offset=0?time=1477555853
        //请求发起前,进入组
        dGroup.enter()
        SLNetworkTools.requestData(SLMethodType.get, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: parameters) { (result) in
            
            //将数据转化成字典
            guard let resultDic = result as? [String : Any] else { return }
            
            //根据data这个key获取数组
            guard let dataArray = resultDic["data"] as? [[String : Any]] else { return }
            
            //遍历数组,获取字典,并将字典转化成模型对象
            for dic in dataArray {
                let group = SLAnchorGroup.init(dic: dic)
                group.icon_name = "home_header_normal"
                if group.tag_name == "颜值" {
                    continue
                }
                self.anchorGroups.append(group)
            }
            
            //接收数据完毕离开组
            dGroup.leave()
        }
        
        //所有数据请求完毕，就会调用一下方法，然后进行排序
        dGroup.notify(queue: DispatchQueue.main) {
            self.anchorGroups.insert(self.prettyGroup, at: 0)
            self.anchorGroups.insert(self.bigDataGroup, at: 0)
            
            //回调方法
            finishedCallBack()
        }
    }
    
    //发送轮播图的网络请求
    func requestCycleData(_ finishedCallBack: @escaping () -> ()) {
        
        SLNetworkTools.requestData(SLMethodType.get, URLString: "http://www.douyutv.com/api/v1/slide/6", parameters: ["version" : "2.300"]) { (result) in

            //把结果转化成字典类型
            guard let resultDic = result as? [String : Any] else { return }
            
            //根据data这个key取出数组
            guard let dataArray = resultDic["data"] as? [[String : Any]] else { return }
            
            //遍历数组
            for dic in dataArray {
                
                let cycleModel = SLCycleModel(dic: dic)
                self.cycleModels.append(cycleModel)
            }
            
            //回调
            finishedCallBack()
        }
        
    }
}
