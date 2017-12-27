//
//  WMTabbarController.swift
//  swiftTest
//
//  Created by 小小开发仔 on 2017/12/22.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit

class WMTabbarController: UITabBarController {
    var  alipy = AliPayViewController()
    var  rerutationVC = ReputationViewController ()
    var friendVC = FriendViewController()
    var moneyVC = MoneyViewController()
    override func viewDidLoad() {
        super.viewDidLoad()

        self.creatSubView()
    }
    func creatSubView() {
        let aliNav = BaseNavgationController(rootViewController :alipy)
        let aliItem = UITabBarItem.init(title: "支付宝", image: UIImage.init(named: "TabBar_HomeBar"), selectedImage: UIImage.init(named: "TabBar_HomeBar_Sel"))
        aliNav.tabBarItem = aliItem
        
        let reputationNav = BaseNavgationController (rootViewController : rerutationVC)
        let reputationItem = UITabBarItem.init(title: "口碑", image: UIImage.init(named: "TabBar_Businesses"), selectedImage: UIImage.init(named: "TabBar_Businesses_Sel"))
        reputationNav.tabBarItem = reputationItem
        
        let friendNav  = BaseNavgationController(rootViewController : friendVC)
        let friendItem = UITabBarItem.init(title: "朋友", image: UIImage.init(named: "TabBar_Friends"), selectedImage: UIImage.init(named: "TabBar_Friends_Sel"))
        friendNav.tabBarItem = friendItem
        
        let moneyNav = BaseNavgationController (rootViewController : moneyVC)
        let moneyItem =  UITabBarItem.init(title: "我的", image: UIImage.init(named: "TabBar_Assets"), selectedImage: UIImage.init(named: "TabBar_Assets_Sel"))
        moneyNav.tabBarItem = moneyItem
        self.viewControllers = [aliNav,reputationNav,friendNav,moneyNav]
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
