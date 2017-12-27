//
//  ViewController.swift
//  swiftTest
//
//  Created by mac on 2017/10/18.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit
import Alamofire
import  SwiftyJSON

class itemsModel: NSObject {
    
    var reason_id = ""
    var reason_name = ""
    
}
class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
   var dataArray = [itemsModel]()
    var myTableview : UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = ""
        self.uiviewset()
        self.lableset()
        self.buttonset()
        self.tableviewset()
        self.test()
      
        let TJDetailURL:String = "http://app.bilibili.com/x/view?access_key=5b65015c833a54fcb6543f5ab579cff9&actionKey=appkey&aid=6579007&appkey=27eb53fc9058f8c3&build=3060&device=phone&plat=0&platform=ios&sign=80950c02804851e278aa56e94d06dc01&ts=1458631180"
       
        QGNetManager.requestData(.get, URLString: TJDetailURL , parameters: nil) { (result) in
            print(result);
            self.dataArray.removeAll()
            let jsonDict = JSON(result)
            
            let data = jsonDict["data"]["dislike_reasons"].array
            for dataaaa in data! {
                let   model = itemsModel()
                let  numString = String(format:"%d",dataaaa["reason_id"].intValue )
                model.reason_id = numString
                model.reason_name = dataaaa["reason_name"].string ?? ""
                self.dataArray.append(model);
                print(self.dataArray.count)
            }
            self.myTableview.reloadData()
        }
        
    }
    func test() {
        
        
}
    func uiviewset() {
        let view1 = UIView(frame: CGRect(x:10,y:50,width:200,height:200))
        let view2 = UIView (frame: CGRect(x: 60, y: 100, width: 200, height: 200))
        let view3 = UIView(frame: CGRect(x: 110, y: 150, width: 200, height: 200))
        
        view1.backgroundColor = UIColor.red
        view2.backgroundColor = UIColor.green
        view3.backgroundColor = UIColor.blue
        self.view.addSubview(view1);
        self.view.addSubview(view2)
        self.view.addSubview(view3)
        view1.alpha = 0.8;
        view.tag = 10;
        self.view.bringSubview(toFront: view1)
        self.view.sendSubview(toBack: view2)
        self.view.exchangeSubview(at: 3, withSubviewAt: 2)
        view2.removeFromSuperview()
        
    }
    func lableset () {
        let label = UILabel(frame: CGRect(x: 50, y: 50, width: 100, height: 25));
        label.text = "我只是一只小小鱼"
        self.view.addSubview(label)
        label.backgroundColor = UIColor.yellow
        label.textColor = UIColor.blue
        label.shadowColor = UIColor.yellow
        label.shadowOffset = CGSize (width: 2, height: 2)
        label.font = UIFont.systemFont(ofSize: 15)
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.font = UIFont.italicSystemFont(ofSize: 15)
        
    }
    func buttonset() {
        let btn = UIButton(type: UIButtonType.custom)
        btn.frame = CGRect(x: 10, y: 150, width: 100, height: 30)
        btn.setTitle("按钮", for: UIControlState.normal)
        btn.setBackgroundImage(UIImage.init(named: "aaa"), for: UIControlState.normal)
        btn.addTarget(self, action: #selector(btnClick), for: UIControlEvents.touchUpInside)
        self.view.addSubview(btn)
    }
 @objc   func btnClick() {
        
        
    }
    func tableviewset() {
        self.myTableview  = UITableView(frame: CGRect(x: 0, y: 100, width: 300, height: 500), style: UITableViewStyle.plain)
        self.view.addSubview(self.myTableview)
        self.myTableview.dataSource = self
        self.myTableview.delegate = self
        self.myTableview.register(testTableViewCell.classForCoder(), forCellReuseIdentifier: "aaa")
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : testTableViewCell = tableView.dequeueReusableCell(withIdentifier: "aaa", for: indexPath) as! testTableViewCell
     let model = self.dataArray[indexPath.row]
        cell.iconImageView?.text = model.reason_name
        cell.title?.text = model.reason_id
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100;
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

