//
//  SLFunnyViewModel.swift
//  SLDouYu
//
//  Created by CHEUNGYuk Hang Raymond on 2016/11/1.
//  Copyright © 2016年 CHEUNGYuk Hang Raymond. All rights reserved.
//

import UIKit

class SLFunnyViewModel: SLBaseViewModel {

    
    func loadFunnyData(finishedCallBack: @escaping () -> ()) {
        loadAnchorData(isGroupData: false, urlString: "http://capi.douyucdn.cn/api/v1/getColumnRoom/3", parameters: ["limit" : 30, "offset" : 0], finishedCallBack: finishedCallBack)
    }
}
