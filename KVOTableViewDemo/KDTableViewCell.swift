//
//  KDTableViewCell.swift
//  KVOTableViewDemo
//
//  Created by 姚宗超 on 2017/3/6.
//  Copyright © 2017年 姚宗超. All rights reserved.
//

import UIKit

class KDTableViewCell: UITableViewCell {
    lazy var observableKeysSet: NSMutableSet = {
        let set = NSMutableSet.init()
        return set
    }()
    
    var dataItem: KDTableItem? {
        didSet {
            if oldValue != dataItem {
                self.statusLabel.text = dataItem?.statusDes
                self.statusLabel.sizeToFit()
            }
        }
    }
    
    lazy var statusLabel: UILabel = {
        let label = UILabel.init()
        label.layer.borderColor = UIColor.red.cgColor
        label.layer.borderWidth = 2.0
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(self.statusLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.statusLabel.center = self.contentView.center
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func addObserver(_ observer: NSObject, forKeyPath keyPath: String, options: NSKeyValueObservingOptions = [], context: UnsafeMutableRawPointer?) {
        guard !self.observableKeysSet.contains(keyPath) && self.dataItem != nil else {
            return
        }
        
        self.dataItem?.addObserver(observer, forKeyPath: keyPath, options: options, context: context)
    }
    
    override func removeObserver(_ observer: NSObject, forKeyPath keyPath: String) {
        guard self.observableKeysSet.contains(keyPath) && self.dataItem != nil else {
            return
        }
        
        self.dataItem?.removeObserver(observer, forKeyPath: keyPath)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard let key = keyPath else {
            return
        }
        if key == KDTableItem.KVOKeyStatusDes {
            if let des = change?[NSKeyValueChangeKey.newKey] as? String {
                self.statusLabel.text = des
                self.statusLabel.sizeToFit()
            }
        }
    }
}
