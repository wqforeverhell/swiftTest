//
//  QGNetManager.swift
//  swiftTest
//
//  Created by mac on 2017/10/18.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit
import Alamofire

class QGNetManager {
    enum MethodType {
        case get
        case post
    }
    class func requestData(_ type : MethodType, URLString : String, parameters : [String : Any]? = nil, finishedCallback :  @escaping (_ result : Any) -> ()) {
        
        // 1.获取类型
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
       
       
            // 2.发送网络请求
        Alamofire.request(URLString, method: method, parameters: parameters).responseJSON { (response) in
            
            // 3.获取结果
            guard let result = response.result.value else {
                print(response.result.error!)
                return
            }
            // 4.将结果回调出去
            finishedCallback(result)
        }
    
    }
    class func requestPostData (_ type : MethodType, urlstring:String,parameters : [String :Any]? = nil ,finishedCallback : @escaping (_ result : Any)-> ()){
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
    
        Alamofire.request(urlstring, method: method, parameters: parameters).responseJSON { (response) in
            guard let result = response.result.value  else {
                return
            }
            finishedCallback(result)
        }
    }
    
}


