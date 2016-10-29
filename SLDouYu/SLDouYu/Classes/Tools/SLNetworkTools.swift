//
//  SLNetworkTools.swift
//  SLDouYu
//
//  Created by CHEUNGYuk Hang Raymond on 2016/10/27.
//  Copyright © 2016年 CHEUNGYuk Hang Raymond. All rights reserved.
//

import UIKit
import Alamofire

enum SLMethodType {
    case get
    case post
}

class SLNetworkTools {

    //封装Alamofire框架
    class func requestData(_ type: SLMethodType, URLString: String, parameters: [String : Any]? = nil, finishedCallBack: @escaping (_ result: Any) -> ()) {
        
        //1.获取类型
        let method = type == SLMethodType.get ? HTTPMethod.get : HTTPMethod.post
        
        //发送网络请求
        Alamofire.request(URLString, method: method, parameters: parameters).responseJSON { (response) in
            
            //获取结果
            guard let result = response.result.value else {
                print(response.result.error!)
                return
            }
            
            //将结果回调出去
            finishedCallBack(result)
        }
        
        
    }
}
