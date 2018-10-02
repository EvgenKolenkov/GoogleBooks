//
//  ViewController.swift
//  BookTests
//
//  Created by Evgeniy Kolenkov on 20.02.18.
//  Copyright © 2018 Evgeniy Kolenkov. All rights reserved.
//

import UIKit
import GoogleSignIn
import FBSDKLoginKit

class StartViewController: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
    }
    
    @IBAction func googleLoginAction(_ sender: UIButton) {
        GIDSignIn.sharedInstance().signIn()
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
        if let error = error {
            print("\(error.localizedDescription)")
        } else {
            let fullName = user.profile.name
            let email = user.profile.email
            let imageURL = user.profile.imageURL(withDimension: 200)
            let currentUser = User(name: fullName!, eMail: email!, imageURL: imageURL!)
            entering(with: currentUser)
        }
    }
    
    @IBAction func facebookLoginAction(_ sender: UIButton) {
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        fbLoginManager.logIn(withReadPermissions: ["public_profile", "email"], from: self) { [weak self] (result, error) -> Void in
            if error == nil {
                let fbloginresult : FBSDKLoginManagerLoginResult = result!
                if (fbloginresult.isCancelled) {
                    return
                } else {
                    self?.getFacebookUserData()
                }
            }
        }
    }
    
    func getFacebookUserData(){
        if FBSDKAccessToken.current() != nil {
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler: { [weak self] (connection, result, error) -> Void in
                if let error = error {
                    print("\(error.localizedDescription)")
                }
                guard
                    let result = result as? [AnyHashable: Any],
                    let email = result["email"] as? String,
                    let name = result["name"] as? String,
                    let pictureData = result["picture"] as? [String: Any],
                    let data = pictureData["data"] as? [String: Any],
                    let imageUrlString = data["url"] as? String,
                    let imageUrl = URL(string: imageUrlString)
                    else {return}
                
                let currentUser = User(name: name, eMail: email, imageURL: imageUrl)
                self?.entering(with: currentUser)
            })
        }
    }
    
    func entering(with user: User) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let tabBarViewController = storyBoard.instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
        tabBarViewController.currentUser = user
        self.navigationController?.pushViewController(tabBarViewController, animated: true)
    }
}

