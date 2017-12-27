//
//  BaseNavgationController.swift
//  swiftTest
//
//  Created by 小小开发仔 on 2017/12/22.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit

class BaseNavgationController: UINavigationController ,UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        let textAttributes = [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 18),NSAttributedStringKey.foregroundColor : UIColor.white];
        UINavigationBar.appearance().titleTextAttributes = textAttributes
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().barTintColor = kThemeColor
        UINavigationBar.appearance().isTranslucent = true
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent;
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if (self.viewControllers.count > 0) {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }

}
