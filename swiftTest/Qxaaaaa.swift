//
//  Qxaaaaa.swift
//  swiftTest
//
//  Created by 小小开发仔 on 2017/11/3.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit

class Qxaaaaa: NSObject {
    let TJDetailURL:String = "http://app.bilibili.com/x/view?access_key=5b65015c833a54fcb6543f5ab579cff9&actionKey=appkey&aid=6579007&appkey=27eb53fc9058f8c3&build=3060&device=phone&plat=0&platform=ios&sign=80950c02804851e278aa56e94d06dc01&ts=1458631180"
    
    func loadData(finishCallBack :@escaping ()-> ()) {
        QGNetManager.requestData(QGNetManager.MethodType.get, URLString: TJDetailURL , parameters: nil) { (result) in
            print(result);
        }
        
    }
}
