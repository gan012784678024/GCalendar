//
//  GCalendarCell.swift
//  NewSeller
//
//  Created by zlq002 on 2017/3/28.
//  Copyright © 2017年 zlq002. All rights reserved.
//

import UIKit

class GCalendarCell: UICollectionViewCell {
    lazy var dateLabel : UILabel! = {
        let id : UILabel = UILabel.init(frame: self.bounds)
        id.textAlignment = NSTextAlignment.center
        id.font = UIFont.systemFont(ofSize: 16)
        self.addSubview(id)
        return id
    }()
}
