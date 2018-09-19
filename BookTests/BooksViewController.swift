//
//  BooksViewController.swift
//  BookTests
//
//  Created by Evgeniy Kolenkov on 21.02.18.
//  Copyright © 2018 Evgeniy Kolenkov. All rights reserved.
//
import  UIKit
import Foundation


class BooksViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBooksSearchBar: UISearchBar!
    
   static var books = [Book]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        searchBooksSearchBar.delegate = self
        searchBooksSearchBar.becomeFirstResponder()
        tableView.tableFooterView = UIView()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.booksDidLoad),
            name: Notification.Name("NotificationIdentifier"),
            object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: Notification.Name("NotificationIdentifier"), object: nil)
        //NotificationCenter.default.removeObserver(self)
    }
    
    @objc func booksDidLoad() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension BooksViewController: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return BooksViewController.books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "booksCell") as! BooksCell
        cell.bookNameLabel.text = BooksViewController.books[indexPath.row].title
        cell.authorNameLabel.text = BooksViewController.books[indexPath.row].authors[0]
        cell.bookImageView.image = BooksViewController.books[indexPath.row].image
        //cell.selectedBackgroundView?.backgroundColor = UIColor.clear
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailBookSegue" {
            let detailBookViewController = segue.destination as! DetailBookViewController
            if let indexPath = tableView.indexPathForSelectedRow,
                let tabBarViewController = navigationController?.viewControllers[1] as? TabBarViewController {
                if let currentUser = tabBarViewController.currentUser {
                    if currentUser.books.contains(BooksViewController.books[indexPath.row]) {
                        detailBookViewController.currentBook = BooksViewController.books[indexPath.row]
                        detailBookViewController.currentMode = .delete
                    } else {
                        detailBookViewController.currentBook = BooksViewController.books[indexPath.row]
                        detailBookViewController.currentMode = .add
                    }
                }
            }
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)  {
        if searchText.isEmpty {
            BooksViewController.books.removeAll()
            tableView.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        BooksViewController.books.removeAll()
        Networking.getBooksFromAPI(searchBar.text!)
    }
}

