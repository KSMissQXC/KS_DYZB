//
//  KSNetworkTool.swift
//  KS_DYZB
//
//  Created by 耳动人王 on 2016/11/2.
//  Copyright © 2016年 KS. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType{
    case get
    case post
}


//typealias FinishCallBack = (_ result : Any) -> ()

class KSNetworkTool {
  class  func requestData(_ type : MethodType,URLString : String,parameters : [String : Any]? = nil,_ callBack : @escaping (_ result : Any) -> ())  {
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        //发送网络请求
          Alamofire.request(URLString, method: method, parameters: parameters).responseJSON { (respose) in
            //获取结果
            guard let result = respose.result.value else{
                print(respose.result.error ?? "error")
                return
            }
            callBack(result)
            
        }

    }
    
    func loadData(_ finishedCallback : @escaping (_ jsonData : String) -> (),name : String){
        
    }
    
    
}
