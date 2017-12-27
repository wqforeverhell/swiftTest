//
//  MoneyCollectionViewCell.swift
//  SwiftDemo
//
//  Created by 郑文明 on 15/12/1.
//  Copyright © 2015年 郑文明. All rights reserved.
//

import UIKit

class MoneyCollectionViewCell: UICollectionViewCell {

     var desLabel: UILabel!
     var titleIV: UIImageView!
    
     var titleLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        titleIV = UIImageView(frame: CGRect(x: 5, y: 2, width: 40, height: 40));
        self.addSubview(titleIV)
        
        titleLabel = UILabel(frame: CGRect(x: 50, y: 2, width: 130, height: 16))
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        titleLabel.textColor = UIColor.black
        self.addSubview(titleLabel)
        
        desLabel = UILabel(frame: CGRect(x: 5, y: 45, width: 175, height: 16))
        desLabel.font = UIFont.systemFont(ofSize: 15)
        desLabel.textColor = UIColor.blue
        self.addSubview(desLabel)
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }


}
