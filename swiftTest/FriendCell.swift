//
//  FriendCell.swift
//  SwiftDemo
//
//  Created by 郑文明 on 15/12/1.
//  Copyright © 2015年 郑文明. All rights reserved.
//

import UIKit

class FriendCell: UITableViewCell {

     var avatarIV: UIImageView!
    
    var userNameLabel: UILabel!
    
    var desLabel: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        avatarIV = UIImageView(frame: CGRect(x: 5, y: 2, width: 40, height: 40));
        self.addSubview(avatarIV)
        
        userNameLabel = UILabel(frame: CGRect(x: 50, y: 2, width: 130, height: 16))
        userNameLabel.font = UIFont.systemFont(ofSize: 15)
        userNameLabel.textColor = UIColor.black
        self.addSubview(userNameLabel)
        
        desLabel = UILabel(frame: CGRect(x: 5, y: 45, width: 175, height: 16))
        desLabel.font = UIFont.systemFont(ofSize: 15)
        desLabel.textColor = UIColor.blue
        self.addSubview(desLabel)
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)


    }
    
    
}
