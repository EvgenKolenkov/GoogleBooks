//
//  BasketViewController.swift
//  BookTests
//
//  Created by Evgeniy Kolenkov on 21.02.18.
//  Copyright © 2018 Evgeniy Kolenkov. All rights reserved.
//

import Foundation
import  UIKit

class BasketViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
   static var booksInBasket = [Book]()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if let tabBarViewController = navigationController?.viewControllers[1] as? TabBarViewController,
            let currentUser = tabBarViewController.currentUser {
            BasketViewController.booksInBasket = currentUser.books
        }
        tableView.reloadData()
    }
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return BasketViewController.booksInBasket.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "booksCell") as! BooksCell
        cell.bookNameLabel.text = BasketViewController.booksInBasket[indexPath.row].title
        cell.authorNameLabel.text = BasketViewController.booksInBasket[indexPath.row].authors[0]
        cell.bookImageView.image = BasketViewController.booksInBasket[indexPath.row].image
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailBasketSegue" {
            let detailBookViewController = segue.destination as! DetailBookViewController
            if let indexPath = tableView.indexPathForSelectedRow {
                detailBookViewController.currentBook = BasketViewController.booksInBasket[indexPath.row]
                detailBookViewController.currentMode = .delete
            }
        }
    }
}
