//
//  AppFullscreenController.swift
//  AppStore
//
//  Created by Will Wang on 5/27/19.
//  Copyright © 2019 Will Wang. All rights reserved.
//

import UIKit

class AppFullscreenController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(tableView)
        tableView.fillSuperview()
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = UITableViewCell()
            let todayCell = TodayCell()
            cell.addSubview(todayCell)
            todayCell.centerInSuperview(size: .init(width: 450, height: 450))
            
            return cell
        }
        
        let cell = AppFullscreenDescriptionCell()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 450
    }
}
