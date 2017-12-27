//
//  ReputationViewController.swift
//  swiftTest
//
//  Created by 小小开发仔 on 2017/12/22.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit

class ReputationViewController: UIViewController,ChangeCity {
    var leftButton : UIButton?
    override func viewDidLoad() {
        super.viewDidLoad()
    leftButton = UIButton(type: .custom)
    leftButton?.frame = CGRect(x: 0, y: 0, width: 70, height: 40)
    leftButton?.setTitle("广州", for: .normal)
    leftButton?.titleLabel?.font = UIFont.systemFont(ofSize: 15)
    leftButton?.addTarget(self, action: #selector(changeCity(sender:)), for: UIControlEvents.touchUpInside)
    leftButton?.setImage(UIImage(named:""), for: UIControlState.normal)
    leftButton?.imageEdgeInsets = UIEdgeInsetsMake(0, -9, 0, 0)
    leftButton?.titleEdgeInsets = UIEdgeInsetsMake(0, 9, 0, 0)
        let leftButtonItem :UIBarButtonItem = UIBarButtonItem(customView: leftButton!)
        navigationItem.leftBarButtonItem = leftButtonItem
        
    }
    func ChangeCityWithName(cityName: String) {
        leftButton?.setTitle((cityName  as NSString).substring(to: 2), for: UIControlState.normal)
    }
    @objc func changeCity(sender:UIButton ){
        let cityList = CityListViewController();
        cityList.delegate = self
        self.navigationController?.pushViewController(cityList, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
