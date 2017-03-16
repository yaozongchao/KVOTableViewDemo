//
//  ViewController.swift
//  KVOTableViewDemo
//
//  Created by 姚宗超 on 2017/3/6.
//  Copyright © 2017年 姚宗超. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var tableView: UITableView = {
        let view: UITableView = UITableView.init(frame: self.view.frame, style: .plain)
        view.register(KDTableViewCell.self, forCellReuseIdentifier: "KDTableViewCell")
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    lazy var dataArray: NSMutableArray = {
        let array = NSMutableArray.init()
        for i in (1 ... 10) {
            let item = KDTableItem.init(des: "String \(i)")
            array.add(item)
        }
        return array
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.addSubview(self.tableView)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        for (_, cell) in self.tableView.visibleCells.enumerated() {
            if let kdCell = cell as? KDTableViewCell {
                kdCell.removeObserver(kdCell, forKeyPath: "statusDes")
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let idxPaths = self.tableView.indexPathsForVisibleRows {
            self.tableView.reloadRows(at: idxPaths, with: .none)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
        if let cell = tableView.cellForRow(at: indexPath) as? KDTableViewCell {
            cell.dataItem?.setValue("changed", forKey: KDTableItem.KVOKeyStatusDes)
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "KDTableViewCell", for: indexPath) as! KDTableViewCell
        if let item = self.dataArray[indexPath.row] as? KDTableItem {
            cell.dataItem = item
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.addObserver(cell, forKeyPath: KDTableItem.KVOKeyStatusDes, options: .new, context: nil)
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.removeObserver(cell, forKeyPath: KDTableItem.KVOKeyStatusDes)
    }
    
}

