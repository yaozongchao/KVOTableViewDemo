//
//  KDTableItem.swift
//  KVOTableViewDemo
//
//  Created by 姚宗超 on 2017/3/6.
//  Copyright © 2017年 姚宗超. All rights reserved.
//

import UIKit

class KDTableItem: NSObject {
    var statusDes: String?
    
    static let KVOKeyStatusDes = "statusDes"
    
    init(des: String?) {
        super.init()
        self.statusDes = des
    }

}
