//
//  SLAmuseViewModel.swift
//  SLDouYu
//
//  Created by CHEUNGYuk Hang Raymond on 2016/10/31.
//  Copyright © 2016年 CHEUNGYuk Hang Raymond. All rights reserved.
//

import UIKit

class SLAmuseViewModel: SLBaseViewModel {
    
}

extension SLAmuseViewModel {
    
    func loadAmuseData(finishedCallBack: @escaping () -> ()) {
        
        loadAnchorData(isGroupData: true, urlString: "http://capi.douyucdn.cn/api/v1/getHotRoom/2") {
            finishedCallBack()
        }
    }

    
}
