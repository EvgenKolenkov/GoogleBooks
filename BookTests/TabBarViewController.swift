//
//  TabBarViewController.swift
//  BookTests
//
//  Created by Evgeniy Kolenkov on 21.02.18.
//  Copyright © 2018 Evgeniy Kolenkov. All rights reserved.
//

import Foundation
import UIKit

class TabBarViewController: UITabBarController {
   
    var currentUser: User?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.items![0].title = NSLocalizedString("BooksViewController_tabBarItem_title", comment: "")
        self.tabBar.items![1].title = NSLocalizedString("BasketViewController_tabBarItem_title", comment: "")
        self.tabBar.items![2].title = NSLocalizedString("AccountViewController_tabBarItem_title", comment: "")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.hidesBackButton = true
    }
}
