//
//  AliPayViewController.swift
//  swiftTest
//
//  Created by 小小开发仔 on 2017/12/22.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit

class AliPayViewController: UIViewController {
    var topVew :UIView?
    override func viewDidLoad() {
        super.viewDidLoad()
        let leftItem = UIBarButtonItem(title: "<#T##String?#>", style: .plain, target: self, action:
            #selector (showMyOrder))
    navigationItem.leftBarButtonItem = leftItem
        initTopView()
        // Do any additional setup after loading the view.
    }
private    func initTopView() {
    topVew = {
        let tempTopView = UIView(frame: CGRect(x: 0, y: kNavbarHeight, width: kScreenWidth, height: 2*kNavbarHeight))
        tempTopView.backgroundColor  = kThemeColor
        view.addSubview(tempTopView)
        return tempTopView
    }()
    let imageViewWidth : CGFloat = (kScreenWidth/4)
    for index in 0...3 {
        let imageView = UIImageView()
        imageView.tintColor = UIColor.white
        imageView.isUserInteractionEnabled = true
        imageView.frame = CGRect(x: imageViewWidth*CGFloat(index), y: 0, width: imageViewWidth, height: (topVew?.frame.size.height)!)
        let  titleLabel = UILabel(frame: CGRect(x: imageView.frame.origin.x, y: imageView.frame.origin.y + (topVew?.frame.size.height)!*2/3, width: imageViewWidth, height: 30))
        if index == 0 {
            imageView.image = UIImage(named: "scan")
            titleLabel.text = "扫一扫"
        }else if index == 1{
            imageView.image = UIImage(named: "scanStatic")
            titleLabel.text = "付款"
        }else if index == 2 {
            imageView.image = UIImage(named: "scan")
            titleLabel.text = "卡券"
        }
        else if index == 3 {
            imageView.image = UIImage(named: "scanStatic")
            titleLabel.text = "附近"
        }
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor.white
        imageView.tag = index
        imageView.contentMode = .center
        let tap = UITapGestureRecognizer(target: self, action: #selector (topButtonClick(sender:)))
        imageView.addGestureRecognizer(tap)
        topVew?.addSubview(imageView)
        topVew?.addSubview(titleLabel)
    }
}
    @objc func topButtonClick(sender : UITapGestureRecognizer) {
        let imageView : UIImageView = sender.view as! UIImageView
        switch imageView.tag {
        case 0:
            let qrcodeVC : QRCodeScanViewController = QRCodeScanViewController()
            self.navigationController?.pushViewController(qrcodeVC, animated: true)
        case 1:
            print("\(String(describing: sender.view?.tag))")
        case 2:
            print("\(String(describing: sender.view?.tag))")
        case 3 :
            print("\(String(describing: sender.view?.tag))")
        default:
             print("\(sender.view?.tag)")
            
        }
    }
    @objc func showMyOrder(){
        print("ffff")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
