//
//  FriendModel.swift
//  swiftTest
//
//  Created by 小小开发仔 on 2017/12/26.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit

class FriendModel: NSObject {
    var userName: String!
    var userId:String!
    var photo:String?
     init(userName:String,userId:String,photo:String) {
        super.init()
        self.userName = userName
        self.userId = userId
        self.photo = photo
    }
    init (infoDic : NSDictionary){
        super.init()
        self.userId = infoDic["userId"] as! String
        self.userName = infoDic["userName"] as! String
        self.photo = infoDic["photo"] as? String
    }
}
