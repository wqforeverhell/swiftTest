//
//  QRCodeScanViewController.swift
//  swiftTest
//
//  Created by 小小开发仔 on 2017/12/22.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit
import AVFoundation
var customContainerView : UIView!
var customTabbar : UITabBar!
var customLabel : UILabel!
var scanLineView : UIImageView!
var borderIV : UIImageView!

class QRCodeScanViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "扫一扫"
        setUpUI()
        startAnimation()

        // Do any additional setup after loading the view.
    }
    private func setUpUI() {
        let rightBarButtonItem :UIBarButtonItem = UIBarButtonItem(title: "相册", style: .plain, target: self, action: #selector (choosePicFromPhotoLib(sender:)))
        navigationItem.rightBarButtonItem = rightBarButtonItem
        
        customContainerView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth-100, height: kScreenHeight-100))
        customContainerView.center = self.view.center
        customContainerView.clipsToBounds = true
        self.view.addSubview(customContainerView)
        
        customLabel = UILabel (frame: CGRect(x: 0, y: kNavbarHeight+40, width: kScreenWidth, height: 40))
        customLabel.textColor = UIColor.white
        customLabel.textAlignment = NSTextAlignment.center
        view.addSubview(customLabel)
        
        borderIV = UIImageView(frame: customContainerView.frame)
        borderIV.image = UIImage(named: "<#T##String#>");
        borderIV.clipsToBounds = true
        view.addSubview(borderIV)
        
        customTabbar = UITabBar(frame: CGRect(x: 0, y: (kScreenHeight-kNavbarHeight), width: kScreenWidth, height: 49))
        customTabbar.delegate = self as? UITabBarDelegate
        customTabbar.backgroundColor = UIColor.black
        customTabbar.barTintColor = UIColor.black
        view.addSubview(customTabbar)
        
        let leftBarItem :UITabBarItem = UITabBarItem(title: "", image: UIImage.init(named: "<#T##String#>"), selectedImage: UIImage.init(named: "<#T##String#>"))
        let rightBarItem : UITabBarItem = UITabBarItem(title: "", image: UIImage.init(named: "<#T##String#>"), selectedImage: UIImage.init(named: "<#T##String#>"))
        customTabbar.setItems([leftBarItem,rightBarItem], animated: true)
        customTabbar.selectedItem = customTabbar.items?.first
        
        scanLineView = UIImageView(frame: CGRect(x: 0, y: 0-customContainerView.frame.size.height, width: customContainerView.frame.size.width, height: customContainerView.frame.size.height))
        scanLineView.image = UIImage(named: "aaa")
        borderIV.addSubview(scanLineView)
        
        scanQRCode()
        
        
    }
    //内部控制方法
    private func scanQRCode(){
        if !session.canAddInput(input!)
        {
            return
        }
        if !session.canAddOutput(output){
            return
        }
        session.addInput(input!)
        session.addOutput(output)
        output.metadataObjectTypes = output.availableMetadataObjectTypes
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        
        view.layer.insertSublayer(previewLayer, at: 0)
        previewLayer.frame = view.bounds
        
        view.layer.addSublayer(containerLayer)
        containerLayer.frame = view.bounds
        session.startRunning()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    func startAnimation() {
        UIView.animate(withDuration: 1.5) {() -> Void in
            UIView.setAnimationRepeatCount(MAXFLOAT)
            if (customTabbar.selectedItem == customTabbar.items?.first){
                scanLineView.frame = CGRect(x: scanLineView.frame.origin.x, y: scanLineView.frame.origin.y+customContainerView.frame.size.height+100, width: scanLineView.frame.size.width, height: scanLineView.frame.size.width)
            }
            else {
                scanLineView.frame = CGRect(x: scanLineView.frame.origin.x, y: borderIV.frame.origin.y+borderIV.frame.size.height, width: borderIV.frame.size.width, height: borderIV.frame.size.height)
                
            }
        }
    }
    
    @objc func choosePicFromPhotoLib (sender :UIBarButtonItem) {
        if !UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary)
        {
            return
        }
        let imagePickerVC = UIImagePickerController()
        imagePickerVC.delegate = self
        present(imagePickerVC, animated: true, completion: nil)
    }
    private lazy var  input : AVCaptureDeviceInput? = {
        let device = AVCaptureDevice.default(for: AVMediaType.video)
        return try? AVCaptureDeviceInput(device: device!)
    }()
    private lazy var session : AVCaptureSession = AVCaptureSession()
    private lazy var output :AVCaptureMetadataOutput = {
        let  out = AVCaptureMetadataOutput()
        let viewRect = self.view.frame
        let containerRect = customContainerView.frame
        let x = containerRect.origin.y / viewRect.height
        let y = containerRect.origin.x / viewRect.width
        let width = containerRect.height/viewRect.height
        let height = containerRect.width / viewRect.width
        
        out.rectOfInterest = CGRect(x: x, y: y, width: width, height: height)
        
        return out
    }()
    
    lazy var containerLayer :CALayer = CALayer()
    lazy var previewLayer : AVCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session: self.session)
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension QRCodeScanViewController :UINavigationControllerDelegate,UIImagePickerControllerDelegate {
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            return
        }
        guard let cilmage = CIImage(image: image) else {
            return
        }
        if #available(iOS 8.0, *) {
            let detector = CIDetector(ofType: CIDetectorTypeQRCode, context: nil, options: [CIDetectorAccuracy:CIDetectorAccuracyLow])
            let results = detector?.features(in: cilmage)
            for result in results! {
                customLabel.text = (result as! CIQRCodeFeature).messageString
            }
        }else {
            
        }
        picker.dismiss(animated: true) {
            self.startAnimation()
        }
    }
}
extension QRCodeScanViewController :AVCaptureMetadataOutputObjectsDelegate{
    private func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        customLabel.text = metadataObjects.last?.stringValue
        clearLayers()
        guard let metadata = metadataObjects.last as? AVMetadataObject else {
            return
            
        }
        let objc  = previewLayer.transformedMetadataObject(for: metadata)
        drawlines(objc: objc as! AVMetadataMachineReadableCodeObject)
    }
    
    private func drawlines (objc : AVMetadataMachineReadableCodeObject){
        
        guard let array : [CGPoint] = objc.corners else
        {
            return
        }
        
        let layer = CAShapeLayer()
        layer.lineWidth = 2
        layer.strokeColor = UIColor.green.cgColor
        layer.fillColor = UIColor.clear.cgColor
        
        let path = UIBezierPath()
        let point = CGPoint(x: 0, y: 0)
        var index = 0
        index += 1
        CGPoint(dictionaryRepresentation: (array[index] as! CFDictionary))
        path.move(to: point)
        while index < array.count {
            index+=1
            CGPoint(dictionaryRepresentation: (array[index] as! CFDictionary))
            path.addLine(to: point)
        }
        path.close()
        layer.path = path.cgPath
        containerLayer.addSublayer(layer)
    }
    private func clearLayers(){
       guard let subLayers = containerLayer.sublayers else { return
        
        }
        for layer in subLayers {
            layer.removeFromSuperlayer()
        }
    }
}
extension QRCodeScanViewController :UITabBarDelegate {
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if (tabBar.selectedItem == customTabbar.items?.first){
            UIView.animate(withDuration: 0.5, animations: {() -> Void in
                borderIV.frame = customContainerView.frame
                borderIV.center = self.view.center
                scanLineView.image = UIImage(named: "<#T##String#>")
                
            })
        }else {
            UIView.animate(withDuration: 0.5, animations: {
                borderIV.frame = CGRect(x: borderIV.frame.origin.x, y: borderIV.frame.origin.y, width: borderIV.frame.size.width, height: borderIV.frame.size.width/2)
                borderIV.center = self.view.center
                scanLineView.image = UIImage(named: "<#T##String#>")
            })
        }
    }
}
