//
//  BaseTabBarController.swift
//  AppStore
//
//  Created by Will Wang on 3/9/19.
//  Copyright © 2019 Will Wang. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let todayNavController = createNavControllers(viewController: UIViewController(), title: "Today", tabIcon: #imageLiteral(resourceName: "today_icon"))
        let appsNavController = createNavControllers(viewController: UIViewController(), title: "Apps", tabIcon:#imageLiteral(resourceName: "apps"))
        let searchNavController = createNavControllers(viewController: AppSearchController(), title: "Search", tabIcon: #imageLiteral(resourceName: "search"))
        
        
        viewControllers = [searchNavController,appsNavController,todayNavController]
    }
    

    fileprivate func createNavControllers(viewController: UIViewController, title: String, tabIcon: UIImage) -> UIViewController {
        viewController.view.backgroundColor = .white
        viewController.navigationItem.title = title
        
        let navController = UINavigationController(rootViewController: viewController)
        navController.navigationBar.prefersLargeTitles = true
        navController.tabBarItem.title = title
        navController.tabBarItem.image = tabIcon
        
        return navController
    }

}
