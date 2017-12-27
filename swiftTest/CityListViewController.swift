//
//  CityListViewController.swift
//  swiftTest
//
//  Created by 小小开发仔 on 2017/12/25.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit
import CoreLocation

protocol ChangeCity : NSObjectProtocol {
    func ChangeCityWithName(cityName:String)
}

class CityListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate {
    var currentCityLabel : UILabel?
    var friendsTable : UITableView?
    var cities :NSDictionary?
    var keys : [String]?
    weak var delegate :ChangeCity?
    var locationManeager : CLLocationManager = CLLocationManager()
    var currLocation : CLLocation!
    func loadData () {
        let path :String = Bundle.main.path(forResource: "citydict", ofType: "plist")!
        cities = NSDictionary(contentsOfFile: path)
        
        let allkeys = cities!.allKeys as NSArray
        let sortedStates = allkeys.sortedArray(using: #selector (NSNumber.compare(_:)))
        keys = sortedStates as? Array<String>
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        locationManeager.stopUpdatingLocation()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        locationManeager.startUpdatingLocation()
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currLocation = locations.last! as CLLocation
        self.reverseGeocode(sender : currLocation)
        
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    func reverseGeocode(sender : AnyObject) {
        let geocoder = CLGeocoder()
        var p : CLPlacemark!
        geocoder.reverseGeocodeLocation(currLocation) { (placemarks, error) -> Void  in
            if error != nil {
                
           }
            let pm = placemarks! as [CLPlacemark]
            if(pm.count > 0){
                p = placemarks![0]
                guard p != nil
                    else {
                        return
                
            }
                let arrayforProvince : [String] = (p!.name?.components(separatedBy: "省"))!
                let city : String = arrayforProvince.last!
                let arrayforcity : [String] = (city.components(separatedBy: "市"))
                self.currentCityLabel?.text = "  "+(arrayforcity.last)!
            }else {
                
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "选择城市"
        locationManeager = CLLocationManager()
        locationManeager.delegate = self
        locationManeager.desiredAccuracy = kCLLocationAccuracyBest
        locationManeager.distanceFilter = kCLLocationAccuracyKilometer
        locationManeager.startUpdatingLocation()
        loadData()
        initUI()
        // Do any additional setup after loading the view.
    }
    func tapToChangeCity(sender :UITapGestureRecognizer){
        if ((currentCityLabel?.text?.isEmpty) == nil) {
            return
        }
        let city :String = ((currentCityLabel?.text)! as NSString).substring(from: 4)
        delegate?.ChangeCityWithName(cityName: city)
        navigationController?.popViewController(animated: true)
    }
    private func initUI(){
  let headerLabel = UILabel()
        headerLabel.frame = CGRect(x: 0, y: kNavbarHeight, width: kScreenWidth, height: 20)
        headerLabel.text = "当前城市"
        headerLabel.backgroundColor = kBackGroundColor
        view.addSubview(headerLabel)
        
        currentCityLabel = UILabel(frame: CGRect(x: headerLabel.frame.origin.x, y: headerLabel.frame.origin.y+headerLabel.frame.size.height, width: headerLabel.frame.size.width, height: headerLabel.frame.size.height + 20))
        currentCityLabel!.backgroundColor = UIColor.white
        currentCityLabel?.textColor = UIColor.orange
        currentCityLabel?.isUserInteractionEnabled = true
        view.addSubview(currentCityLabel!)
        let tap = UITapGestureRecognizer(target: self, action: Selector(("tapToChangeCity:")))
        currentCityLabel?.addGestureRecognizer(tap)
        
        friendsTable = UITableView(frame:CGRect(x: (currentCityLabel?.frame.origin.x)!, y: (currentCityLabel?.frame.origin.y)!+(currentCityLabel?.frame.size.height)!, width: (currentCityLabel?.frame.size.width)!, height: (kScreenHeight-(currentCityLabel?.frame.size.height)!)-headerLabel.frame.size.height), style: .plain)
        friendsTable?.delegate = self;
        friendsTable?.dataSource = self
        friendsTable?.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(friendsTable!)

    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return (keys?.count)!
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let keys_:NSArray = NSArray(array: keys!)
        let key = keys_.object(at: section)
        let temp : NSArray = (cities?.object(forKey: key))! as! NSArray
        return temp.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        let keysTemp :NSArray = NSArray(array: keys!)
        let key   = keysTemp.object(at: indexPath.section)
        let temp :NSArray = (cities?.object(forKey: key))! as! NSArray
        cell.textLabel?.text = temp.object(at: indexPath.row) as? String
        return cell
        
    }
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return keys
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let  headerLabel =  UILabel(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 20))
        headerLabel.backgroundColor = kBackGroundColor
        let keys_:NSArray = NSArray(array: keys!)
        let key = keys_.object(at: section)
        let textString = ""+(key as? String)!
        headerLabel.text = textString;
        return headerLabel
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        let keysTemp : NSArray = NSArray(array: keys!)
        let key = keysTemp.object(at: indexPath.section)
        let temp :NSArray = (cities?.object(forKey: key))! as! NSArray
        self.delegate?.ChangeCityWithName(cityName: temp.object(at: indexPath.row) as! String)
        navigationController?.popViewController(animated: true)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
