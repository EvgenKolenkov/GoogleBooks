//
//  Helper.swift
//  BookTests
//
//  Created by Evgeniy Kolenkov on 07.03.18.
//  Copyright © 2018 Evgeniy Kolenkov. All rights reserved.
//

import Foundation
import UIKit

class Helper {
    
    class func showAlert (_ title: String, _ message: String, _ vc: UIViewController) {
        let alertControler = UIAlertController(title: title, message: message
            , preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Ok", style: .cancel) { action in
            vc.navigationController?.popViewController(animated: true)
        }
        alertControler.addAction(cancelAction)
        vc.present(alertControler, animated: true)
    }
}
