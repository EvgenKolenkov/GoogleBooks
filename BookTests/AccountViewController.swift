//
//  AccountViewController.swift
//  BookTests
//
//  Created by Evgeniy Kolenkov on 21.02.18.
//  Copyright © 2018 Evgeniy Kolenkov. All rights reserved.
//

import Foundation
import UIKit
import GoogleSignIn

class AccountViewController: UIViewController {
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var logOutButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logOutButton.titleLabel?.text = NSLocalizedString("logOutButton_titleLabel", comment: "")
        if let myTabBarControler = tabBarController as? TabBarViewController,
            let currentUser = myTabBarControler.currentUser {
            let name = currentUser.name
            userNameLabel.text = name
            if let imageURL = currentUser.imageURL,
                let data = try? Data.init(contentsOf: imageURL) {
                userImageView.image = UIImage(data: data)
                userImageView.layer.cornerRadius = userImageView.frame.size.width / 2
                userImageView.clipsToBounds = true
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func logOutButtonAction(_ sender: UIButton) {
        GIDSignIn.sharedInstance().signOut()
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}
