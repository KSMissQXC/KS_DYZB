//
//  KSRecommendViewModel.swift
//  KS_DYZB
//
//  Created by 耳动人王 on 2016/11/2.
//  Copyright © 2016年 KS. All rights reserved.
//

import UIKit


class KSRecommendViewModel {
    
    fileprivate lazy var bigDataGroup : KSAnchorGroup = KSAnchorGroup()
    fileprivate lazy var prettyGroup : KSAnchorGroup = KSAnchorGroup()
    
    lazy var cycleModels : [KSHomeCycleModel] = [KSHomeCycleModel]()

    
    lazy var anchorGroups : [KSAnchorGroup] = [KSAnchorGroup]()

    

}

extension KSRecommendViewModel{
    //发送网络请求
    func requestData(_ callBack : @escaping () -> ()) {
        // 1.定义参数
        let parameters = ["limit" : "4", "offset" : "0", "time" : Date.getCurrentTime()]
//        print("----")

        //创建队列组保证数据都拿到后 回调
        let dGroup = DispatchGroup()
        
        
        //第一部分推荐热门数据
        dGroup.enter()
        KSNetworkTool.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: ["time" : Date.getCurrentTime()], {(result) in
//            print("----")
            guard let resultDict =  result as? [String : NSObject] else{
                return
            }
            
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else{
                return
            }
            
            self.bigDataGroup.tag_name = "热门"
            self.bigDataGroup.icon_name = "home_header_hot"
            print("获取到热门")
            for dict in dataArray{
                let anchor = KSAnchorModel(dict: dict)
//                print(anchor.nickname)
                self.bigDataGroup.anchors.append(anchor)
            }
            dGroup.leave()
        
        })
        
        //请求第二部分颜值数据
        dGroup.enter()
        KSNetworkTool.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: parameters, {(result) in
            guard let resultDict =  result as? [String : NSObject] else{
                return
            }
            
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else{
                return
            }
            
            self.prettyGroup.tag_name = "颜值"
            self.prettyGroup.icon_name = "home_header_phone"
            print("获取到颜值")
            // 3.2.获取主播数据
            for dict in dataArray {
                let anchor = KSAnchorModel(dict: dict)
//                print(anchor.nickname)

                self.prettyGroup.anchors.append(anchor)
            }
            dGroup.leave()

        })
        
        // 5.请求2-12部分游戏数据
        dGroup.enter()
        KSNetworkTool.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: parameters, {(result) in
            // 1.对界面进行处理
            guard let resultDict = result as? [String : Any] else { return }
            guard let dataArray = resultDict["data"] as? [[String : Any]] else { return }
            print("获取到游戏")
            // 2.1.遍历数组中的字典
            for dict in dataArray {
                self.anchorGroups.append(KSAnchorGroup(dict: dict))
            }
            dGroup.leave()
            
        })
        
        // 所有的数据都请求到,之后进行排序
        dGroup.notify(queue: DispatchQueue.main) {
            self.anchorGroups.insert(self.prettyGroup, at: 0)
            self.anchorGroups.insert(self.bigDataGroup, at: 0)
            callBack()
        }
    }
    
    //请求无限轮播数据
    func requestCycleData(_ finishCallback : @escaping () -> ()) {
        KSNetworkTool.requestData(.get, URLString: "http://www.douyutv.com/api/v1/slide/6", parameters: ["version" : "2.310"], {(result) in
            
            // 1.获取整体字典数据
            guard let resultDict = result as? [String : NSObject] else { return }
            
            // 2.根据data的key获取数据
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            
            
            // 3.字典转模型对象
            for dict in dataArray {
                self.cycleModels.append(KSHomeCycleModel(dict: dict))
            }
            
            finishCallback()

            
        
        })
        
        
        
    }
    
    
    
    
    
    
    
    
}

