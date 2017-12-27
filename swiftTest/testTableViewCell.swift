//
//  testTableViewCell.swift
//  swiftTest
//
//  Created by mac on 2017/10/18.
//  Copyright © 2017年 mac. All rights reserved.
//

import UIKit

class testTableViewCell: UITableViewCell {
    var titleString:String?
    var iconImageName :String?
    var title :UILabel?
    var iconImageView :UILabel?
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        self.iconImageView = UILabel()
        self.iconImageView?.backgroundColor = UIColor.blue
        self.iconImageView = UILabel(frame: CGRect(x: 20, y: 20, width: 160, height: 15))
        self.contentView.addSubview(self.iconImageView!)
        self.title = UILabel()
        self.title = UILabel(frame: CGRect(x: 20, y: 60, width: 100, height: 20))
       // self.title?.backgroundColor = UIColor.black
        self.title?.font = UIFont.boldSystemFont(ofSize: 15)
        self.contentView.addSubview(self.title!)
        setUpviews()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }

    func setUpviews() {
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
