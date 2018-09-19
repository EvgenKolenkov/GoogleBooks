//
//  DetailBookViewController.swift
//  BookTests
//
//  Created by Evgeniy Kolenkov on 21.02.18.
//  Copyright © 2018 Evgeniy Kolenkov. All rights reserved.
//

import Foundation
import UIKit

enum Mode {
    
    case delete
    case add
    
    var titleMode : String {
        switch self {
        case .delete:
            return NSLocalizedString("barButtonItem_title_delete", comment: "")
        case .add:
            return NSLocalizedString("barButtonItem_title_toBasket", comment: "")
        }
    }
}

class DetailBookViewController: UIViewController {
    
    var currentBook: Book?
    var currentMode: Mode = .add
    
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var bookAuthorLabel: UILabel!
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var bookInfoTextView: UITextView!
    @IBOutlet weak var barButtonItem: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bookTitleLabel.text = currentBook?.title
        bookAuthorLabel.text = currentBook?.authors[0]
        bookInfoTextView.text = currentBook?.info
        bookImageView.image = currentBook?.image
        barButtonItem.title = currentMode.titleMode
        navigationItem.title = NSLocalizedString("navigationItem_title", comment: "")
    }
    
    @IBAction func barButtonItemAction(_ sender: UIBarButtonItem) {
        if currentMode == .add {
            if let tabBarViewController = navigationController?.viewControllers[1] as? TabBarViewController {
                if let currentBook = currentBook,
                    let currentUser = tabBarViewController.currentUser {
                    currentUser.books.append(currentBook)
                    Helper.showAlert(NSLocalizedString("alert_title", comment: ""), NSLocalizedString("alert_addMessage", comment: ""), self)
                }
            }
            
        } else
            if currentMode == .delete,
                let tabBarViewController = navigationController?.viewControllers[1] as? TabBarViewController {
                if let newBooks = tabBarViewController.currentUser?.books.filter({ $0 != self.currentBook!})
                {
                    tabBarViewController.currentUser?.books = newBooks
                }
        }
        Helper.showAlert(NSLocalizedString("alert_title", comment: ""), NSLocalizedString("alert_deleteMessage", comment: ""), self)
    }
}

